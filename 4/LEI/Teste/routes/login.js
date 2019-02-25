var express = require('express');
var passport = require('passport');
var jwt = require('jsonwebtoken');
var router = express.Router();

/* Login de um utilizador. */
router.post('/processaLogin', async (req, res, next) => {
    passport.authenticate('login', async (err, user, info) => {     
        try {
            if (err || !user) {
                return next(err);
            }
            
            req.login(user, { session : false }, async (error) => {
                if (error) {
                    return next(error);
                }

                var myuser = { _id : user._id, username : user.username };
                // Geração do token
                var token = jwt.sign({ user : myuser }, 'lei');
                req.session.token = token;
                res.redirect('/');
            });
        } catch (error) {
            return next(error);
        }
    })(req, res, next);
});

/* Verifica se utilizador tem login feito. */
router.get('/verificaLogin', function(req, res){
    if (req.session.token) {
        jwt.verify(req.session.token, 'ibanda', function(err, decoded) {
            res.end('{\"Success\" : \"Logged in!\", \"status\" : 200}');
        })(req, res, next);
    } else {
        return next(error);
    }
})

/* Get login. */
router.get('/', function(req, res) {
    res.render('login');
})

module.exports = router;