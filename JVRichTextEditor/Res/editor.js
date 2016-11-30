/**
 * Created by liu on 16/11/25.
 */

window.onload = function() {
    console.log("hello world");
    
    var editor = getEditor();
    editor.style.height = window.innerHeight+"px";
    
    jv_editor.init();
};

function getEditor() {
    var div = document.getElementById("editor");
    return div;
}

jv_editor = {};

jv_editor.currentSelection = null;

jv_editor.init = function() {
    
};

// Helper

jv_editor.closerParentNode = function() {
    var parentNode = null;
    var selection = window.getSelection();
    var range = selection.getRangeAt(0).cloneRange();
    var currentNode = range.commonAncestorContainer;
    while (currentNode) {
        if (currentNode.nodeType == document.ELEMENT_NODE) {
            parentNode = currentNode;
            break;
        }
        currentNode = currentNode.parentElement;
    }
    return parentNode;
};

jv_editor.closerParentNodeWithName = function(nodeName) {
    nodeName = nodeName.toLowerCase();
    var parentNode = null;
    var selection = window.getSelection();
    var range = selection.getRangeAt(0).cloneRange();
    
    var currentNode = range.commonAncestorContainer;
    while (currentNode) {
        if (currentNode.nodeName == document.body.nodeName) {
            break;
        }
        if (currentNode.nodeName.toLowerCase() == nodeName
            && currentNode.nodeType == document.ELEMENT_NODE) {
            parentNode = currentNode;
            break;
        }
        currentNode = currentNode.parentElement;
    }
    return parentNode;
};

jv_editor.focusEditor = function() {
    // the following was taken from http://stackoverflow.com/questions/1125292/how-to-move-cursor-to-end-of-contenteditable-entity/3866442#3866442
    // and ensures we move the cursor to the end of the editor
    //var editor = $('#zss_editor_content');
    var editor = getEditor()
    var range = document.createRange();
    range.selectNodeContents(editor);
    range.collapse(false);
    var selection = window.getSelection();
    selection.removeAllRanges();
    selection.addRange(range);
    //    alert(editor);
    editor.focus();
};

jv_editor.backuprange = function(){
    var selection = window.getSelection();
    var range = selection.getRangeAt(0);
    jv_editor.currentSelection = {
        "startContainer": range.startContainer,
        "startOffset":range.startOffset,
        "endContainer":range.endContainer,
        "endOffset":range.endOffset
    };
};

jv_editor.restorerange = function(){
    var selection = window.getSelection();
    selection.removeAllRanges();
    var range = document.createRange();
    range.setStart(jv_editor.currentSelection.startContainer, jv_editor.currentSelection.startOffset);
    range.setEnd(jv_editor.currentSelection.endContainer, jv_editor.currentSelection.endOffset);
    selection.addRange(range);
    return selection;
    // console.log(range);
};

// function

jv_editor.setPlaceholder = function(placeholder) {
    var editor = getEditor();
    editor.setAttribute("placeholder", placeholder)
}

jv_editor.setPadding = function(top, right, bottom, left) {
    var editor = getEditor();
    var s = top+'px '+right+'px '+bottom+'px '+left+'px';
    editor.style.padding = s;
}

jv_editor.setMargin = function(top, right, bottom, left) {
    var editor = getEditor();
    var s = top+'px '+right+'px '+bottom+'px '+left+'px';
    editor.style.margin = s;
}

jv_editor.undo = function(){
    document.execCommand('undo', false, null);
};

jv_editor.redo = function(){
    document.execCommand('redo', false, null);
};

jv_editor.setBold = function() {
    console.log("setBold");
    document.execCommand('bold', false, null);
    //zss_editor.enabledEditingItems();
};

jv_editor.setItalic = function() {
    console.log("setItalic");
    document.execCommand('italic', false, null);
//    jv_editor.focusEditor();
    //zss_editor.enabledEditingItems();
};

jv_editor.setSubscript = function() {
    document.execCommand('subscript', false, null);
    //zss_editor.enabledEditingItems();
};

jv_editor.setSuperscript = function () {
    document.execCommand('superscript', false, null);
    //zss_editor.enabledEditingItems();
};

jv_editor.setStrikeThrough = function() {
    document.execCommand('strikeThrough', false, null);
    //zss_editor.enabledEditingItems();
};

jv_editor.setUnderline = function() {
    document.execCommand('underline', false, null);
    //zss_editor.enabledEditingItems();
};

jv_editor.setBlockquote = function() {
    document.execCommand('formatBlock', false, '<blockquote>');
    //zss_editor.enabledEditingItems();
};

jv_editor.removeFormating = function() {
    document.execCommand('removeFormat', false, null);
    //zss_editor.enabledEditingItems();
};

jv_editor.setHorizontalRule = function() {
    document.execCommand('insertHorizontalRule', false, null);
    //zss_editor.enabledEditingItems();
};

jv_editor.setHeading = function(heading) {
    //var current_selection = $(zss_editor.getSelectedNode());
    //var t = current_selection.prop("tagName").toLowerCase();
    
    /*
     var node = zss_extend.closerParentNode();
     console.log(node);
     if (node.nodeName.toLowerCase() == 'li') {
     var div = document.createElement('div');
     div.innerHTML = node.innerHTML;
     node.innerHTML = '';
     node.appendChild(div);
     // console.log(li);
     console.log(div);
     }
     
    var is_heading = (t == 'h1' || t == 'h2' || t == 'h3' || t == 'h4' || t == 'h5' || t == 'h6');
    if (!is_heading) {
        return;
    }
    */
    
    var is_heading = (heading == 'h1' || heading == 'h2' || heading == 'h3' || heading == 'h4' || heading == 'h5' || heading == 'h6');
    if (!is_heading) {
        return;
    }
    
    document.execCommand('formatBlock', false, '<'+heading+'>');
    
    //if (is_heading && heading == t) {
    //    var c = current_selection.html();
    //    current_selection.replaceWith(c);
    //} else {
    //    document.execCommand('formatBlock', false, '<'+heading+'>');
    //}
    //
    //zss_editor.enabledEditingItems();
};

jv_editor.setParagraph = function() {
    //var current_selection = $(zss_editor.getSelectedNode());
    //var t = current_selection.prop("tagName").toLowerCase();
    //var is_paragraph = (t == 'p');
    //if (is_paragraph) {
    //    var c = current_selection.html();
    //    current_selection.replaceWith(c);
    //} else {
    //    document.execCommand('formatBlock', false, '<p>');
    //}
    //zss_editor.enabledEditingItems();
    document.execCommand('formatBlock', false, '<p>');
};


jv_editor.setOrderedList = function() {
    document.execCommand('insertOrderedList', false, null);
//    jv_editor.enabledEditingItems();
};

jv_editor.setUnorderedList = function() {
    document.execCommand('insertUnorderedList', false, null);
//    jv_editor.enabledEditingItems();
};

jv_editor.setTypeOrderedList = function(t) {
    var node = jv_editor.closerParentNodeWithName('ol');
    t = t || '1';
    console.log('node', node);
    if (node != null) { // 插入节点
        if (node.type == t) {
            document.execCommand('insertOrderedList', false, null);
        }
        else {
            node.type = t;
        }
    }
    else {
        document.execCommand('insertOrderedList', false, null);
        node = jv_editor.closerParentNodeWithName('ol');
        node.type = t;
    }
//    zss_editor.enabledEditingItems();
};

jv_editor.setTypeUnorderedList = function(t) {
    var node = jv_editor.closerParentNodeWithName('ul');
    t = t || 'disc';
    if (node != null) { // 插入节点
        if (node.type == t) {
            document.execCommand('insertUnorderedList', false, null);
        }
        else {
            node.type = t;
        }
    }
    else {
        document.execCommand('insertUnorderedList', false, null);
        node = jv_editor.closerParentNodeWithName('ul');
        node.type = t;
    }
//    zss_editor.enabledEditingItems();
};


jv_editor.setOrderedList = function() {
    jv_editor.setTypeOrderedList('1');
};

jv_editor.setUpCharOrderedList = function() {
    jv_editor.setTypeOrderedList('A');
};

jv_editor.setLowCharOrderedList = function() {
    jv_editor.setTypeOrderedList('a');
};

jv_editor.setUpRomanOrderedList = function() {
    jv_editor.setTypeOrderedList('I');
};

jv_editor.setLowRomanOrderedList = function() {
    jv_editor.setTypeOrderedList('i');
};

jv_editor.setUnorderedList = function() {
    jv_editor.setTypeUnorderedList('disc');
};

jv_editor.setSquareUnorderedList = function() {
    jv_editor.setTypeUnorderedList('square');
};

jv_editor.setCircleUnorderedList = function() {
    jv_editor.setTypeUnorderedList('circle');
};

jv_editor.setJustifyCenter = function() {
    document.execCommand('justifyCenter', false, null);
};

jv_editor.setJustifyLeft = function() {
    document.execCommand('justifyLeft', false, null);
};

jv_editor.setJustifyRight = function() {
    document.execCommand('justifyRight', false, null);
};

jv_editor.setJustifyFull = function() {
     document.execCommand('justifyFull', false, null);
};

jv_editor.setSubscript = function() {
    document.execCommand('subscript', false, null);
};

jv_editor.setSuperscript = function() {
    document.execCommand('superscript', false, null);
};

jv_editor.setTextColor = function(color) {
    document.execCommand("styleWithCSS", null, true);
    document.execCommand('foreColor', false, color);
    document.execCommand("styleWithCSS", null, false);
};

jv_editor.setBackgroundColor = function(color) {
    document.execCommand("styleWithCSS", null, true);
    document.execCommand('hiliteColor', false, color);
    document.execCommand("styleWithCSS", null, false);
};

jv_editor.insertLink = function(url, title) {
//    zss_editor.restorerange();
    var html = '<a href="'+url+'" title="'+title+'">'+title+'</a>';
    jv_editor.insertHTML(html);
//    jv_editor.enabledEditingItems();
};

jv_editor.insertImage = function (url, alt) {
    
    var range;
    var select;
    var nextNode;
    var html = null;
    
    if (alt !== null) {
        html = '<img src="'+url+'" alt="'+alt+'" max-width:100%;/>';
    } else {
        html = '<img src="'+url+'" max-width:100%;/>';
    }
    
    select = window.getSelection();
    if (document.TEXT_NODE == select.baseNode.nodeType) {
        html = "<div>" + html + "</div>";
    }
    
    jv_editor.insertHTML(html);
    
    range = window.getSelection().getRangeAt(0);
    nextNode = range.endContainer.nextSibling;
    
    console.log(range, nextNode);
    
    if (nextNode) {
        jv_editor.currentSelection = {
            "startContainer": nextNode,
            "startOffset": 0,
            "endContainer": nextNode,
            "endOffset": 0
        };
    }
    else {
        html = "<div><br/></div> <div><br/></div>";
        //        alert("<div><br></div>");
        jv_editor.insertHTML(html);
    }
    
//    jv_editor.enabledEditingItems();
}

jv_editor.setHTML = function(html) {
    var editor = getEditor();
    editor.html(html);
};

jv_editor.insertHTML = function(html) {
    document.execCommand('insertHTML', false, html);
//    zss_editor.enabledEditingItems();
};

jv_editor.getHTML = function() {
    var editor = getEditor();
    var html = editor.innerHTML;
    return html;
};

jv_editor.getText = function() {
    var editor = getEditor();
    var html = editor.text();
    return html;
}