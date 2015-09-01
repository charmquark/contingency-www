// Array.isArray polyfill
if (!Array.isArray) {
    Array.isArray = function(arg) {
        return Object.prototype.toString.call(arg) === '[object Array]';
    };
}


function element(tag, content, attrs) {
    var element = document.createElement(tag);
    if (attrs != null) {
        for (name in attrs) {
            element.setAttribute(name, attrs[name]);
        }
    }
    if (content != null) {
        setElementContent(element, content);
    }
    return element;
}


function setElementContent(element, content) {
    if (typeof content == "string") {
        element.appendChild(text(content));
    }
    else if (Array.isArray(content)) {
        for (idx = 0; idx < content.length; ++idx) {
            element.appendChild(content[idx]);
        }
    }
    else {
        element.appendChild(content);
    }
}


function text(content) {
    return document.createTextNode(content);
}
