/**
 * Copyright (c) 2000-2009, Jasig, Inc.
 * See license distributed with this file and available online at
 * https://www.ja-sig.org/svn/jasig-parent/tags/rel-10/license-header.txt
 */
package org.jasig.portal.groups.pags.testers;

/**
 * Tests an <code>IPerson</code> attribute for String equality and  
 * answers true if any of the possibly multiple values of the 
 * attribute equals the test value. 
 * <p>
 * @author Dan Ellentuck
 * @version $Revision$
 */

public class StringEqualsTester extends StringTester {

public StringEqualsTester(String attribute, String test) {
    super(attribute, test);
}
public boolean test(String att) {
    return att.equals(testValue);
}

}
