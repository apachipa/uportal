/**
 * Copyright (c) 2000-2009, Jasig, Inc.
 * See license distributed with this file and available online at
 * https://www.ja-sig.org/svn/jasig-parent/tags/rel-10/license-header.txt
 */
package org.jasig.portal.layout.node;

import org.w3c.dom.Document;
import org.w3c.dom.Element;


/**
 * An interface describing common features of user layout nodes,
 * that is channels and folders
 *
 * @author Peter Kharchenko  {@link <a href="mailto:pkharchenko@interactivebusiness.com"">pkharchenko@interactivebusiness.com"</a>}
 * @version 1.0
 */
public interface IUserLayoutNodeDescription {

    /**
      * Constants indicating the type of a node
      */
    public static final int CHANNEL = 1;
    public static final int FOLDER = 2;

    /**
     * Returns a node Id.
     * The Id has to be unique in the entire user layout document.
     *
     * @return a <code>String</code> value
     */
    public String getId();

    /**
     * Set a new node Id.
     * The Id has to be unique in the entire user layout document.
     *
     */
    public void setId(String id);

    /**
     * Determine a name associated with this node.
     *
     * @return a folder/channel name.
     */
    public String getName();

     /**
     * Returns a type of the node, could be FOLDER or CHANNEL integer constant.
     *
     * @return a type
     */
    public int getType();

    public void setName(String name);

    public boolean isUnremovable();
    public void setUnremovable(boolean setting);

    public boolean isImmutable();
    public void setImmutable(boolean setting);

    public boolean isHidden();
    public void setHidden(boolean setting);


    /**
     * Creates a <code>org.w3c.dom.Element</code> representation of the current node.
     *
     * @param root a <code>Document</code> for which the <code>Element</code> should be created.
     * @return a <code>Element</code> value
     */
    public Element getXML(Document root);

    public void addNodeAttributes(Element node);

    /**
     * Returns true if child nodes can be added to the node.
     * Added by SCT for DLM.
     */
    public boolean isAddChildAllowed();

    /**
     * Set whether or not child nodes can be added to this node.
     * Added by SCT for DLM.
     */
    public void setAddChildAllowed( boolean setting );

    /**
     * Returns true if the node's attributes can be edited.
     * Added by SCT for DLM.
     */
    public boolean isEditAllowed();

    /**
     * Set whether a node's attributes can be edited or not.
     * Added by SCT for DLM.
     */
    public void setEditAllowed( boolean setting );

    /**
     * Returns the precedence value for this node. The precedence is 0.0 for
     * a user owned node and the value of the node's owning fragment's
     * precedence for a node incorporated from another fragment. Added by SCT
     * for DLM.
     */
    public double getPrecedence();

    /**
     * Set the precedence of a node. See getPrecedence for more information.
     * Added by SCT for DLM.
     */
    public void setPrecedence( double setting );

    /**
     * Returns true if the node can be moved. Added by SCT for DLM.
     */
    public boolean isMoveAllowed();

    /**
     * Set whether a node can be moved or not. Added by SCT for DLM.
     */
    public void setMoveAllowed( boolean setting );

    /**
     * Returns true if the node can be deleted. Added by SCT for DLM.
     */
    public boolean isDeleteAllowed();

    /**
     * Set whether a node can be deleted or not. Added by SCT for DLM.
     */
    public void setDeleteAllowed( boolean setting );
    
    
}
