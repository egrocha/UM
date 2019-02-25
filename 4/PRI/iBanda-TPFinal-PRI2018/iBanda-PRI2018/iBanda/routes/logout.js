var express = require('express');
var jwt = require('jsonwebtoken');
var router = express.Router();


/* Get logout. */
router.get('/', function(req, res) {
    if (req.session.token) {
        jwt.verify(req.session.token, 'ibanda', function(err, decoded) {
            if (err) {
                res.redirect('/');
            } else {
                req.session.destroy();
                req.logout();
                res.redirect('/');
            }
        });
    } else {
        res.redirect('/')
    }
});

module.exports = router;