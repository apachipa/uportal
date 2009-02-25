/**
 * Copyright (c) 2000-2009, Jasig, Inc.
 * See license distributed with this file and available online at
 * https://www.ja-sig.org/svn/jasig-parent/tags/rel-10/license-header.txt
 */
package org.jasig.portal.portlet.om;


/**
 * A portlet definition is equivalant to a published ChannelDefinition. 
 * 
 * @author Eric Dalquist
 * @version $Revision$
 */
public interface IPortletDefinition {
    /**
     * @return The unique identifier for this portlet definition.
     */
    public IPortletDefinitionId getPortletDefinitionId();
    
    /**
     * @return The ID of the {@link org.jasig.portal.ChannelDefinition} this portlet definition is based on.
     */
    public int getChannelDefinitionId();
    
    /**
     * @return The preferences for this portlet definition, will not be null.
     */
    public IPortletPreferences getPortletPreferences();
    
    /**
     * @param portletPreferences The preferences for this portlet definition.
     * @throws IllegalArgumentException If preferences is null.
     */
    public void setPortletPreferences(IPortletPreferences portletPreferences);
}
