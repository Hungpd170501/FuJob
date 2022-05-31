/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.SignatureException;
import io.jsonwebtoken.UnsupportedJwtException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import se1621.constant.Constant;
import se1621.dto.Role;
import se1621.dto.User;

/**
 *
 * @author ACER
 */
public class JwtTokenUtils {

    static final String CLAIM_KEY_USERNAME = "sub";
    static final String CLAIM_KEY_CREATED = "created";
    static final String CLAIM_KEY_PASSWORD = "password";
    static final String CLAIM_KEY_EMAIL = "email";
    private Long expiration = 900L;
    private final String SECRET_KEY=Constant.TOKEN_SECRET_KEY;
    public String getUsernameFromToken(String token) {
        String username;
        try {
            final Claims claims = getClaimsFromToken(token);
            username = claims.getSubject();
        } catch (Exception e) {
            username = null;
        }
        return username;
    }

    public String getPasswordFromToken(String token) {
        String password;
        try {
            final Claims claims = getClaimsFromToken(token);
            password = (String) claims.get(CLAIM_KEY_PASSWORD);
        } catch (Exception e) {
            password = null;
        }
        return password;
    }
    public String getEmailFromToken(String token) {
        String password;
        try {
            final Claims claims = getClaimsFromToken(token);
            password = (String) claims.get(CLAIM_KEY_EMAIL);
        } catch (Exception e) {
            password = null;
        }
        return password;
    }

    public Date getCreatedDateFromToken(String token) {
        Date created;
        try {
            final Claims claims = getClaimsFromToken(token);
            created = new Date((Long) claims.get(CLAIM_KEY_CREATED));
        } catch (Exception e) {
            created = null;
        }
        return created;
    }

    public Date getExpirationDateFromToken(String token) {
        Date expiration;
        try {
            final Claims claims = getClaimsFromToken(token);
            expiration = claims.getExpiration();
        } catch (Exception e) {
            expiration = null;
        }
        return expiration;
    }

    private Claims getClaimsFromToken(String token) {
        Claims claims;
        try {
            claims = Jwts.parser()
                    .setSigningKey(SECRET_KEY)
                    .parseClaimsJws(token)
                    .getBody();
        } catch (Exception e) {
            claims = null;
        }
        return claims;
    }

    private Date generateExpirationDate() {
        return new Date(System.currentTimeMillis() + expiration * 1000);
    }

    public Boolean isTokenExpired(String token) {
        final Date expiration = getExpirationDateFromToken(token);
        return expiration.before(new Date());
    }

//    private Boolean isCreatedBeforeLastPasswordReset(Date created, Date lastPasswordReset) {
//        return (lastPasswordReset != null && created.before(lastPasswordReset));
//    }
    public String generateToken(User userDetails) {
        Map<String, Object> claims = new HashMap<>();
        claims.put(CLAIM_KEY_USERNAME, userDetails.getUsername());
        claims.put(CLAIM_KEY_PASSWORD, userDetails.getPassword());
        claims.put(CLAIM_KEY_EMAIL, userDetails.getEmail());
        claims.put(CLAIM_KEY_CREATED, new Date());
        return generateToken(claims);
    }

    String generateToken(Map<String, Object> claims) {
        return Jwts.builder()
                .setClaims(claims)
                .setExpiration(generateExpirationDate())
                .signWith(SignatureAlgorithm.HS512, SECRET_KEY)
                .compact();
    }

//    public Boolean canTokenBeRefreshed(String token, Date lastPasswordReset) {
//        final Date created = getCreatedDateFromToken(token);
//        return !isCreatedBeforeLastPasswordReset(created, lastPasswordReset)
//                && (!isTokenExpired(token) || ignoreTokenExpiration(token));
//    }
    public String refreshToken(String token) {
        String refreshedToken;
        try {
            final Claims claims = getClaimsFromToken(token);
            claims.put(CLAIM_KEY_CREATED, new Date());
            refreshedToken = generateToken(claims);
        } catch (Exception e) {
            refreshedToken = null;
        }
        return refreshedToken;
    }

    public Boolean validateToken(String token, User userDetails) {
        final String username = getUsernameFromToken(token);
        final Date created = getCreatedDateFromToken(token);
        final Date expiration = getExpirationDateFromToken(token);
        return (username.equals(userDetails.getUsername())
                && !isTokenExpired(token)
                && StringUtils.equals(userDetails.getPassword(), token));
    }
    
    public Boolean canParseToken( final String compactToken ) {        
        Boolean check=true;
        try{
            Jwts.parser()
                   .setSigningKey( SECRET_KEY )
                   .parseClaimsJws(compactToken );
        }catch(ExpiredJwtException | MalformedJwtException | SignatureException | UnsupportedJwtException | IllegalArgumentException e){
            check=false;
        }
        return check;
    }
//    public static void main(String[] args) {
//        JwtTokenUtils jwtTokenUtils= new JwtTokenUtils();
//        User user=new User(0, CLAIM_KEY_USERNAME, CLAIM_KEY_PASSWORD, CLAIM_KEY_USERNAME, CLAIM_KEY_USERNAME, CLAIM_KEY_CREATED, 0, new Role(CLAIM_KEY_CREATED, CLAIM_KEY_USERNAME));
//        jwtTokenUtils.generateToken(user);
//        System.out.println(jwtTokenUtils.generateToken(user));
//    }
}
