/**
 * Copyright (c) 2000-2009, Jasig, Inc.
 * See license distributed with this file and available online at
 * https://www.ja-sig.org/svn/jasig-parent/tags/rel-10/license-header.txt
 */
package org.jasig.portal.security.provider;

/**
 * <p>The factory class for the simple security context. Just returns a new
 * instance of the JAASSecurityContext.</p>
 *
 * @author Nathan Jacobs
 * @version $Revision$ $Date$
 */

import org.jasig.portal.security.ISecurityContext;
import org.jasig.portal.security.ISecurityContextFactory;

public class JAASSecurityContextFactory implements ISecurityContextFactory {
  public ISecurityContext getSecurityContext() {
    return new JAASSecurityContext();
  }
}
