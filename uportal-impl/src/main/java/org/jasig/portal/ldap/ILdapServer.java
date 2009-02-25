/**
 * Copyright (c) 2000-2009, Jasig, Inc.
 * See license distributed with this file and available online at
 * https://www.ja-sig.org/svn/jasig-parent/tags/rel-10/license-header.txt
 */
package org.jasig.portal.ldap;

import javax.naming.NamingException;
import javax.naming.directory.DirContext;

import org.springframework.ldap.core.support.LdapContextSource;


/**
 * The <code>ILdapServer</code> interface defines a set of methods
 * to be used to create a connection to an LDAP server, release the
 * connection and get information about the connection.
 * 
 * @author Eric Dalquist <a href="mailto:edalquist@unicon.net">edalquist@unicon.net</a>
 * @version $Revision$
 * @deprecated Framework code should access {@link LdapContextSource} objects in the spring context via injection instead of using these APIs.
 */
public interface ILdapServer {

    /**
     * Gets an LDAP directory context. 
     * 
     * @return an LDAP directory context object.
     * @throws NamingException If there is a problem connecting to the ldap server.
     */
    public DirContext getConnection() throws NamingException;
    
    /**
     * Gets the base DN used to search the LDAP directory context.
     * 
     * @return a DN to use as reference point or context for queries
     */    
    public String getBaseDN();
    
    /**
     * Gets the uid attribute used to search the LDAP directory context.
     * 
     * @return a DN to use as reference point or context for queries
     */    
    public String getUidAttribute();
    
    /**
     * Releases an LDAP directory context.
     * 
     * @param conn an LDAP directory context object
     */    
    public void releaseConnection (DirContext conn);
    
}
