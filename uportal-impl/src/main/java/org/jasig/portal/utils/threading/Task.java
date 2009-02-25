/**
 * Copyright (c) 2000-2009, Jasig, Inc.
 * See license distributed with this file and available online at
 * https://www.ja-sig.org/svn/jasig-parent/tags/rel-10/license-header.txt
 */
package org.jasig.portal.utils.threading;

/**
 * A task which can be executed asynchronously
 * @author Aaron Hamid (arh14 at cornell dot edu)
 */
public interface Task extends Runnable {
  /**
   * Returns the exception that occurred during execution, if any
   * @return the exception that occurred during execution, if any
   */
  Exception getException();
}