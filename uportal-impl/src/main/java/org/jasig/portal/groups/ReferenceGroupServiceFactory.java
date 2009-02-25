/**
 * Copyright (c) 2000-2009, Jasig, Inc.
 * See license distributed with this file and available online at
 * https://www.ja-sig.org/svn/jasig-parent/tags/rel-10/license-header.txt
 */
package org.jasig.portal.groups;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Creates the reference implemetation of <code>IGroupService</code>.
 * @author Dan Ellentuck
 * @version $Revision$
 * @deprecated
 */

@Deprecated
public class ReferenceGroupServiceFactory implements IGroupServiceFactory {
    
    private static final Log log = LogFactory.getLog(ReferenceGroupServiceFactory.class);
    
/**
 * ReferenceGroupServiceFactory constructor.
 */
public ReferenceGroupServiceFactory() {
        super();
}
/**
 * Return an instance of the service implementation.
 * @return org.jasig.portal.groups.IGroupService
 * @exception org.jasig.portal.groups.GroupsException
 */
public IGroupService newGroupService() throws GroupsException
{
    try
        { return ReferenceGroupService.singleton(); }
    catch ( GroupsException ge )
    {
        log.error(ge.getMessage(), ge);
        throw new GroupsException(ge);
    }
}
}
