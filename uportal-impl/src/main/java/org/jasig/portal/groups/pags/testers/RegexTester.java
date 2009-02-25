/**
 * Copyright (c) 2000-2009, Jasig, Inc.
 * See license distributed with this file and available online at
 * https://www.ja-sig.org/svn/jasig-parent/tags/rel-10/license-header.txt
 */
package org.jasig.portal.groups.pags.testers;

import org.apache.oro.text.perl.Perl5Util;


/**
 * A tester for matching the possibly multiple values of an attribute 
 * against a regular expression.  If any of the values matches the pattern, 
 * the tester returns true.
 * <p>
 * @author Dan Ellentuck
 * @version $Revision$
 */

public class RegexTester extends StringTester {
    protected Perl5Util regexMatcher = null;
    protected String pattern = null;
    protected char PATTERN_DELIMITER = '/';
    
public RegexTester(String attribute, String test) {
    super(attribute, test);
    initialize();
}
protected void initialize() {
    regexMatcher = new Perl5Util();
    pattern = PATTERN_DELIMITER + testValue + PATTERN_DELIMITER; 
}
public boolean test(String att) {
    boolean result = false;
    try
        { result = regexMatcher.match(pattern,att); }
    catch ( Throwable t ) { }  // Bad pattern?
    return result; 
}

}
