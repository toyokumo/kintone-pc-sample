var path = require("path");

module.exports = function(name) {
    var re = /(\.(js|coffee)$)/i;
    return re.test(path.extname(name));
};
