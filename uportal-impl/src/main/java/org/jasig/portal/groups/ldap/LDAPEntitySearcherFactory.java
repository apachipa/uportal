/**
 * Copyright (c) 2000-2009, Jasig, Inc.
 * See license distributed with this file and available online at
 * https://www.ja-sig.org/svn/jasig-parent/tags/rel-10/license-header.txt
 */
package org.jasig.portal.groups.ldap;

import org.jasig.portal.groups.GroupsException;
import org.jasig.portal.groups.IEntitySearcher;
import org.jasig.portal.groups.IEntitySearcherFactory;

/**
 * Returns an instance of the ldap <code>IEntitySearcher</code>.
 * @author Dan Ellentuck
 * @version $Revision$
 */

public class LDAPEntitySearcherFactory implements IEntitySearcherFactory {
/**
 * LdapEntitySearcherFactory constructor.
 */
public LDAPEntitySearcherFactory() {
    super();
}
/**
 * Return an instance of the entity searcher implementation.
 * @return IEntitySearcher
 * @exception GroupsException
 */
public IEntitySearcher newEntitySearcher() throws GroupsException
{
    return newInstance();
}
/**
 * Return an instance of the entity searcher implementation.
 * @return IEntitySearcher
 * @exception GroupsException
 */
public IEntitySearcher newInstance() throws GroupsException
{
    return (IEntitySearcher) new LDAPGroupStoreFactory().newGroupStore();
}
}
