/**
 * Copyright (c) 2000-2009, Jasig, Inc.
 * See license distributed with this file and available online at
 * https://www.ja-sig.org/svn/jasig-parent/tags/rel-10/license-header.txt
 */
package org.jasig.portal.channels.portlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jasig.portal.ChannelCacheKey;
import org.jasig.portal.ChannelRuntimeData;
import org.jasig.portal.ChannelRuntimeProperties;
import org.jasig.portal.ChannelStaticData;
import org.jasig.portal.PortalControlStructures;
import org.jasig.portal.PortalEvent;
import org.jasig.portal.PortalException;
import org.jasig.portal.channels.support.TitledChannelRuntimeProperties;
import org.jasig.portal.utils.threading.TrackingThreadLocal;
import org.springframework.web.context.WebApplicationContext;
import org.xml.sax.ContentHandler;

/**
 * An attempt at a channel that can wrap a singleton spring-configured {@link ISpringPortletChannel} instance and
 * delegate execution to. This class simply must maintain the instance data and pass it on to the ISpringPortletChannel
 * for each method. The channel gets the name of the {@link ISpringPortletChannel} bean to use from the parameter named
 * 'springBeanName' using the {@link #SPRING_BEAN_NAME_PARAM} constant.
 * 
 * This class also attempts to eagerly clean up session & request scoped resources at the end of each 'lifecycle' set
 * of calls.
 * 
 * @author Eric Dalquist
 * @version $Revision$
 */
public class CSpringPortletAdaptor implements IPortletAdaptor {
    public static final String SPRING_BEAN_NAME_PARAM = "springBeanName";
    public static final String DEFAULT_SPRING_BEAN_NAME = "portletChannel";
    
    protected final Log logger = LogFactory.getLog(this.getClass());
    
    //Data available for the duration of this classes existence (setStaticData to SESSION_DONE)
    private ChannelStaticData channelStaticData;
    private ISpringPortletChannel springPortletChannel;
    
    //Lifecycle data only availabe during a request
    private final static TrackingThreadLocal<ChannelRuntimeData> channelRuntimeDataLocal = new TrackingThreadLocal<ChannelRuntimeData>();
    private final static TrackingThreadLocal<PortalControlStructures> portalControlStructuresLocal = new TrackingThreadLocal<PortalControlStructures>();
    

    /* (non-Javadoc)
     * @see org.jasig.portal.IChannel#setStaticData(org.jasig.portal.ChannelStaticData)
     */
    public void setStaticData(ChannelStaticData sd) throws PortalException {
        try {
            final PortalControlStructures portalControlStructures = this.portalControlStructuresLocal.get();
            if (portalControlStructures == null) {
                throw new IllegalStateException("No PortalControlStructures is associated with this IChannel, either no valid request has started or the request is complete.");
            }

            //Determine the name of the spring bean to wrap
            String beanName = sd.getParameter(SPRING_BEAN_NAME_PARAM);
            if (beanName == null) {
                beanName = DEFAULT_SPRING_BEAN_NAME;
            }
            
            if (this.logger.isDebugEnabled()) {
                this.logger.debug("Using ISpringPortletChannel named '" + beanName + "'");
            }
            
            final WebApplicationContext applicationContext = sd.getWebApplicationContext();
            if (applicationContext == null) {
                throw new IllegalStateException("No WebApplicationContext provided by ChannelStaticData");
            }
            
            final ISpringPortletChannel springPortletChannel = (ISpringPortletChannel)applicationContext.getBean(beanName, ISpringPortletChannel.class);
            
            //Initialize the static channel immediately with the instance data
            springPortletChannel.initSession(sd, portalControlStructures);
            
            //Only set the local variables if the initSession call completes
            this.channelStaticData = sd;
            this.springPortletChannel = springPortletChannel;
        }
        finally {
            this.portalControlStructuresLocal.remove();
        }
    }
    
    
    /* (non-Javadoc)
     * @see org.jasig.portal.IPrivileged#setPortalControlStructures(org.jasig.portal.PortalControlStructures)
     */
    public void setPortalControlStructures(PortalControlStructures pcs) throws PortalException {
        this.portalControlStructuresLocal.set(pcs);
    }

    /* (non-Javadoc)
     * @see org.jasig.portal.IChannel#setRuntimeData(org.jasig.portal.ChannelRuntimeData)
     */
    public void setRuntimeData(ChannelRuntimeData rd) throws PortalException {
        final PortalControlStructures portalControlStructures = this.portalControlStructuresLocal.get();
        if (portalControlStructures == null) {
            throw new IllegalStateException("setPortalControlStructures must be set before setRuntimeData is called");
        }
        
        this.channelRuntimeDataLocal.set(rd);

        //Attach the runtime data as an attribute on the request so it is accessible to other portlet rendering related classes  
        final HttpServletRequest httpServletRequest = portalControlStructures.getHttpServletRequest();
        httpServletRequest.setAttribute(ATTRIBUTE__RUNTIME_DATA, rd);
    }
    
    /* (non-Javadoc)
     * @see org.jasig.portal.channels.portlet.IPortletAdaptor#processAction()
     */
    public void processAction() throws PortalException {
        try {
            if (this.channelStaticData == null) {
                throw new IllegalStateException("No ChannelStaticData is associated with this IChannel, either the channel has not yet been initialized or should be destroyed.");
            }
            final PortalControlStructures portalControlStructures = this.portalControlStructuresLocal.get();
            if (portalControlStructures == null) {
                throw new IllegalStateException("No PortalControlStructures is associated with this IChannel, either no valid request has started or the request is complete.");
            }
            final ChannelRuntimeData channelRuntimeData = this.channelRuntimeDataLocal.get();
            if (channelRuntimeData == null) {
                throw new IllegalStateException("No ChannelRuntimeData is associated with this IChannel, either no valid request has started or the request is complete.");
            }
            
            this.springPortletChannel.action(this.channelStaticData, portalControlStructures, channelRuntimeData);
        }
        finally {
            this.portalControlStructuresLocal.remove();
            this.channelRuntimeDataLocal.remove();
        }
    }

    /* (non-Javadoc)
     * @see org.jasig.portal.ICacheable#generateKey()
     */
    public ChannelCacheKey generateKey() {
        if (this.channelStaticData == null) {
            throw new IllegalStateException("No ChannelStaticData is associated with this IChannel, either the channel has not yet been initialized or should be destroyed.");
        }
        final PortalControlStructures portalControlStructures = this.portalControlStructuresLocal.get();
        if (portalControlStructures == null) {
            throw new IllegalStateException("No PortalControlStructures is associated with this IChannel, either no valid request has started or the request is complete.");
        }
        final ChannelRuntimeData channelRuntimeData = this.channelRuntimeDataLocal.get();
        if (channelRuntimeData == null) {
            throw new IllegalStateException("No ChannelRuntimeData is associated with this IChannel, either no valid request has started or the request is complete.");
        }
        
        return this.springPortletChannel.generateKey(this.channelStaticData, portalControlStructures, channelRuntimeData);
    }

    /* (non-Javadoc)
     * @see org.jasig.portal.ICacheable#isCacheValid(java.lang.Object)
     */
    public boolean isCacheValid(Object validity) {
        if (this.channelStaticData == null) {
            throw new IllegalStateException("No ChannelStaticData is associated with this IChannel, either the channel has not yet been initialized or should be destroyed.");
        }
        final PortalControlStructures portalControlStructures = this.portalControlStructuresLocal.get();
        if (portalControlStructures == null) {
            throw new IllegalStateException("No PortalControlStructures is associated with this IChannel, either no valid request has started or the request is complete.");
        }
        final ChannelRuntimeData channelRuntimeData = this.channelRuntimeDataLocal.get();
        if (channelRuntimeData == null) {
            throw new IllegalStateException("No ChannelRuntimeData is associated with this IChannel, either no valid request has started or the request is complete.");
        }
        
        return this.springPortletChannel.isCacheValid(this.channelStaticData, portalControlStructures, channelRuntimeData, validity);
    }

    /* (non-Javadoc)
     * @see org.jasig.portal.ICharacterChannel#renderCharacters(java.io.PrintWriter)
     */
    public void renderCharacters(PrintWriter pw) throws PortalException {
        if (this.channelStaticData == null) {
            throw new IllegalStateException("No ChannelStaticData is associated with this IChannel, either the channel has not yet been initialized or should be destroyed.");
        }
        final PortalControlStructures portalControlStructures = this.portalControlStructuresLocal.get();
        if (portalControlStructures == null) {
            throw new IllegalStateException("No PortalControlStructures is associated with this IChannel, either no valid request has started or the request is complete.");
        }
        final ChannelRuntimeData channelRuntimeData = this.channelRuntimeDataLocal.get();
        if (channelRuntimeData == null) {
            throw new IllegalStateException("No ChannelRuntimeData is associated with this IChannel, either no valid request has started or the request is complete.");
        }
        
        this.springPortletChannel.render(this.channelStaticData, portalControlStructures, channelRuntimeData, pw);
    }

    /* (non-Javadoc)
     * @see org.jasig.portal.IChannel#getRuntimeProperties()
     */
    public ChannelRuntimeProperties getRuntimeProperties() {
        try {
            if (this.channelStaticData == null) {
                throw new IllegalStateException("No ChannelStaticData is associated with this IChannel, either the channel has not yet been initialized or should be destroyed.");
            }
            final PortalControlStructures portalControlStructures = this.portalControlStructuresLocal.get();
            if (portalControlStructures == null) {
                throw new IllegalStateException("No PortalControlStructures is associated with this IChannel, either no valid request has started or the request is complete.");
            }
            final ChannelRuntimeData channelRuntimeData = this.channelRuntimeDataLocal.get();
            if (channelRuntimeData == null) {
                throw new IllegalStateException("No ChannelRuntimeData is associated with this IChannel, either no valid request has started or the request is complete.");
            }
            
            final String title = this.springPortletChannel.getTitle(this.channelStaticData, portalControlStructures, channelRuntimeData);
            return new TitledChannelRuntimeProperties(title);
        }
        finally {
            this.channelRuntimeDataLocal.remove();
            this.portalControlStructuresLocal.remove();
        }
    }

    /* (non-Javadoc)
     * @see org.jasig.portal.IChannel#receiveEvent(org.jasig.portal.PortalEvent)
     */
    public void receiveEvent(PortalEvent ev) {
        try {
            if (this.channelStaticData == null) {
                throw new IllegalStateException("No ChannelStaticData is associated with this IChannel, either the channel has not yet been initialized or should be destroyed.");
            }
            final PortalControlStructures portalControlStructures = this.portalControlStructuresLocal.get();
            if (portalControlStructures == null) {
                throw new IllegalStateException("No PortalControlStructures is associated with this IChannel, either no valid request has started or the request is complete.");
            }

            this.springPortletChannel.portalEvent(this.channelStaticData, portalControlStructures, ev);
        }
        finally {
            this.portalControlStructuresLocal.remove();
            
            //If the session is done this channel object should never be used again, clean up references
            if (PortalEvent.SESSION_DONE == ev.getEventNumber()) {
                this.springPortletChannel = null;
                this.channelStaticData = null;
            }
        }
    }
    
    /* (non-Javadoc)
     * @see org.jasig.portal.IResetableChannel#prepareForRefresh()
     */
    public void prepareForRefresh() {
        try {
            if (this.channelStaticData == null) {
                throw new IllegalStateException("No ChannelStaticData is associated with this IChannel, either the channel has not yet been initialized or should be destroyed.");
            }
            final PortalControlStructures portalControlStructures = this.portalControlStructuresLocal.get();
            if (portalControlStructures == null) {
                throw new IllegalStateException("No PortalControlStructures is associated with this IChannel, either no valid request has started or the request is complete.");
            }
            final ChannelRuntimeData channelRuntimeData = this.channelRuntimeDataLocal.get();
            if (channelRuntimeData == null) {
                throw new IllegalStateException("No ChannelRuntimeData is associated with this IChannel, either no valid request has started or the request is complete.");
            }
         
            this.springPortletChannel.prepareForRefresh(this.channelStaticData, portalControlStructures, channelRuntimeData);
        }
        finally {
            this.portalControlStructuresLocal.remove();
            this.channelRuntimeDataLocal.remove();
        }
    }


    /* (non-Javadoc)
     * @see org.jasig.portal.IResetableChannel#prepareForReset()
     */
    public void prepareForReset() {
        try {
            if (this.channelStaticData == null) {
                throw new IllegalStateException("No ChannelStaticData is associated with this IChannel, either the channel has not yet been initialized or should be destroyed.");
            }
            final PortalControlStructures portalControlStructures = this.portalControlStructuresLocal.get();
            if (portalControlStructures == null) {
                throw new IllegalStateException("No PortalControlStructures is associated with this IChannel, either no valid request has started or the request is complete.");
            }
            final ChannelRuntimeData channelRuntimeData = this.channelRuntimeDataLocal.get();
            if (channelRuntimeData == null) {
                throw new IllegalStateException("No ChannelRuntimeData is associated with this IChannel, either no valid request has started or the request is complete.");
            }
         
            this.springPortletChannel.prepareForReset(this.channelStaticData, portalControlStructures, channelRuntimeData);
        }
        finally {
            this.portalControlStructuresLocal.remove();
            this.channelRuntimeDataLocal.remove();
        }        
    }
    
    /* (non-Javadoc)
     * @see org.jasig.portal.IDirectResponse#setResponse(javax.servlet.http.HttpServletResponse)
     */
    public void setResponse(HttpServletResponse response) throws PortalException {
        final PrintWriter writer;
        try {
            writer = response.getWriter();
        }
        catch (IOException e) {
            throw new PortalException("Failed to access PrintWriter on response to initiate rendering");
        }

        this.renderCharacters(writer);
    }

    /* (non-Javadoc)
     * @see org.jasig.portal.IChannel#renderXML(org.xml.sax.ContentHandler)
     */
    public void renderXML(ContentHandler out) throws PortalException {
        throw new UnsupportedOperationException("renderXML is not valid to call for ICharacterChannel");
    }
}
