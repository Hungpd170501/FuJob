/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package se1621.test;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.SignatureException;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.impl.crypto.MacProvider;
import javax.crypto.SecretKey;
import java.time.Duration;
import java.time.Instant;
import java.time.temporal.TemporalAmount;
import java.util.Base64;
import java.util.Date;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class JavaTest {

    final static String CLAIM_ROLE = "role";

    final static SignatureAlgorithm SIGNATURE_ALGORITHM = SignatureAlgorithm.HS512;
//    final static SecretKey SECRET_KEY = MacProvider.generateKey(SIGNATURE_ALGORITHM);
    final static String SECRET_KEY = "X4[OSEu4^~!\"[,oGC1)OFX2Xrb-,i=SkW&%Vf;_@pQo_W4rLq:D]sZlN[[]dtxR";
    final static TemporalAmount TOKEN_VALIDITY = Duration.ofHours(1L);

    public static void main(String[] args) throws ParseException {

        String token = createToken("test", "admin");

        System.out.println("Token : " + token);
        System.out.println("Token False : " + token + "xx");

        Jws<Claims> x = parseToken(token);

        System.out.println("Validate True : " + x.getSignature());

//        Jws<Claims> x2 = parseToken(token + "xx");
//        System.out.println("Validate False : " + x2.getSignature());
        
//        Jwts.parser().parse(token).toString();
String[] chunks = token.split("\\.");
Base64.Decoder decoder = Base64.getUrlDecoder();

String header = new String(decoder.decode(chunks[0]));
String payload = new String(decoder.decode(chunks[1]));
        System.out.println(header);
        System.out.println(payload);
           }
    	public static String createToken( final String subject, final String role ) {
        final Instant now = Instant.now();
        final Date expiryDate = Date.from( now.plus( TOKEN_VALIDITY ) );
        return Jwts.builder()
                   .setSubject( subject )
                   .claim( CLAIM_ROLE, role )
                    .claim("cai lol gi the", "cai lol nay ne")
                   .setExpiration( expiryDate )
                   .setIssuedAt( Date.from( now ) )
                   .signWith( SIGNATURE_ALGORITHM, SECRET_KEY )
                   .compact();
    }
	
	/**
	 * 
	 * @param compactToken : Token ที่ต้องการจะ Valiadate
	 * @return 2 อย่าง คือ 1. throws Exception ถ้าไม่ผ่าน 2.Object ถ้าผ่าน
	 * @throws ExpiredJwtException
	 * @throws UnsupportedJwtException
	 * @throws MalformedJwtException
	 * @throws SignatureException
	 * @throws IllegalArgumentException
	 */
	public static Jws<Claims> parseToken( final String compactToken ) throws ExpiredJwtException,UnsupportedJwtException,MalformedJwtException,SignatureException,IllegalArgumentException {
        
		//ใช้ KEY เดียวกับตอนเข้ารหัส และส่ง Token ตัวเดียวกันมา
		return Jwts.parser()
                   .setSigningKey( SECRET_KEY )
                   .parseClaimsJws(compactToken );
    }

//    public static String createToken(final String subject, final String role) {
//        final Instant now = Instant.now();
//        final Date expiryDate = Date.from(now.plus(TOKEN_VALIDITY));
//        return Jwts.builder()
//                .setSubject(subject)
//                .claim(CLAIM_ROLE, role)
//                .setExpiration(expiryDate)
//                .setIssuedAt(Date.from(now))
//                .signWith(SIGNATURE_ALGORITHM, SECRET_KEY)
//                .compact();
//    }
//
//    public static Jws<Claims> parseToken(final String compactToken)
//            throws ExpiredJwtException,
//            UnsupportedJwtException,
//            MalformedJwtException,
//            SignatureException,
//            IllegalArgumentException {
//        return Jwts.parser()
//                .setSigningKey(SECRET_KEY)
//                .parseClaimsJws(compactToken);
//    }

}
