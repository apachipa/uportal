<%--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License. You may obtain a
    copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on
    an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied. See the License for the
    specific language governing permissions and limitations
    under the License.

--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="portlet" uri="http://java.sun.com/portlet"%>

<portlet:defineObjects/>

<div class="fl-widget portlet" role="section">
	<div class="fl-widget-titlebar portlet-title" role="sectionhead">
		<h2 role="heading">Delete Portlet Entities</h2>
		<h3>Select an entity to delete</h3>
	</div>
	
    <div class="fl-col-flex2 portlet-toolbar" role="toolbar">
        <div class="fl-col">
            <ul>
                <li><a href="<portlet:renderURL><portlet:param name="view" value="import"/></portlet:renderURL>">Import</a></li>
                <li><a href="<portlet:renderURL><portlet:param name="view" value="export"/></portlet:renderURL>">Export</a></li>
            </ul>
        </div>
    </div>
    
    <div class="fl-widget-content portlet-body" role="main">
    
        <div class="portlet-section" role="region">
        
            <div class="portlet-section-body">

                <div class="portlet-msg-alert" role="alert">
					<p>Deleting some entities can do very bad things to 
					your portal.  By default, all delete operations are disabled;  use this feature 
					with caution.</p>
				</div>
				
                <div class="portlet-note" role="note">
                    <p>Use this form to delete portal entities through this Portlet.</p>
                </div>
                
                <form method="POST" action="<portlet:actionURL><portlet:param name="action" value="doDelete"/><portlet:param name="view" value="status"/></portlet:actionURL>">
                    <p>
						<label class="portlet-form-label" for="entityType">Type:</label>
						<select id="entityType" name="entityType">
						    <option>[Select Type]</option>
						    <c:forEach items="${supportedTypes}" var="type">
						        <option value="${type}"><c:out value="${type}"/></option>
						    </c:forEach>
						</select>
						
						<label class="portlet-form-label" for="sysid">Id:</label>
						<input type="text" id="sysid" name="sysid"/>
					</p>
                    
                    <div class="portlet-button-group">
                        <input class="portlet-button portlet-button-primary" type="submit" value="Import"/>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>