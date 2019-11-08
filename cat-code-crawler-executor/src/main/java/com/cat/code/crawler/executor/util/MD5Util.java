package com.cat.code.crawler.executor.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * 生成MD5
 * @author lxw
 */
public class MD5Util {

	private static final char HEX_DIGITS[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };

//	public static void main(String[] args) throws Exception{
//		//System.out.println(getMd5("25959_NOTICE_ENTRY_http://pigcaifu.com/node/notice/2016101101"));
//
//		System.out.println(getMd5("z1993K"));
//	}

	public MD5Util() {}

	public static String getMd5(String plainText) {
			MessageDigest md;
			try {
				md = MessageDigest.getInstance("MD5");
				md.update(plainText.getBytes());
				byte b[] = md.digest();
				int i;

				StringBuffer buf = new StringBuffer("");
				for (int offset = 0; offset < b.length; offset++) {
					i = b[offset];
					if (i < 0)
						i += 256;
					if (i < 16)
						buf.append("0");
					buf.append(Integer.toHexString(i));
				}
				return buf.toString();
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return "00000000000000000000000000000000";
	}

	private static String toHexString(byte[] b) {
		StringBuilder sb = new StringBuilder(b.length * 2);
		for (int i = 0; i < b.length; i++) {
			sb.append(HEX_DIGITS[(b[i] & 0xf0) >>> 4]);
			sb.append(HEX_DIGITS[b[i] & 0x0f]);
		}
		return sb.toString();
	}

	public static String bit32(String SourceString) throws Exception {
		MessageDigest digest = MessageDigest.getInstance("MD5");
		digest.update(SourceString.getBytes());
		byte messageDigest[] = digest.digest();
		return toHexString(messageDigest);
	}

	public static String bit16(String SourceString) throws Exception {
		return bit32(SourceString).substring(8, 24);
	}

	public static String bit10(String SourceString) {
		try {
			return bit32(SourceString).substring(14, 24);
		}catch (Exception e){
			e.printStackTrace();
		}
		return "0000000000";
	}

}
