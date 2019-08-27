component singleton=true{

	function init () {
		variables.algorithm = "PBKDF2WithHmacSHA1";
		return this;
	}

	private array function genPasswordPart (
		  	  required string stringType
			, required numeric qty
			, required array passwordArray) {

		if (qty) {
			for(var i = 1; i <= qty; i++) {
				arrayAppend(passwordArray, mid(stringType, randRange(1, len(stringType)), 1));
			}
		}

		return passwordArray;
	}

	string function genPassword (
			  required numeric minLength
	        , numeric qtyNumbers = 0
			, numeric qtyLowerCaseAlpha = 0
			, numeric qtyUpperCaseAlpha = 0
			, numeric qtyOtherChars = 0) {

		var strLowerCaseAlpha = "abcdefghjkmnpqrstuvwxyz";
		var strUpperCaseAlpha = ucase(strLowerCaseAlpha);
		var strNumbers = "23456789";
		var strOtherChars = "!@$%&?*";
		var arPassword = [];
		arPassword = genPasswordPart(strNumbers, qtyNumbers, arPassword);
		arPassword = genPasswordPart(strLowerCaseAlpha, qtyLowerCaseAlpha, arPassword);
		arPassword = genPasswordPart(strUpperCaseAlpha, qtyUpperCaseAlpha, arPassword);
		arPassword = genPasswordPart(strOtherChars, qtyOtherChars, arPassword);

		var remainingLen = minLength - arrayLen(arPassword);
		if (remainingLen > 0) {
			var strAllValidChars = strLowerCaseAlpha & strUpperCaseAlpha & strNumbers & strOtherChars;
			arPassword = genPasswordPart(strAllValidChars, remainingLen, arPassword);
		}

		createObject("java", "java.util.Collections").Shuffle(arPassword);

		return arrayToList(arPassword, "");
	}

	struct function hashPasswordPBKDF2 (required string password, numeric iterations = 10000, numeric saltByteLength = 8) {

		if (iterations < 1000) {
			throw(message="Iterations must be greater than or equal to 1000");
		}

		if (saltbytelength < 8) {
			throw(message="SaltByteLength must be greater than or equal to 8");
		}

		if (len(trim(password)) == 0) {
			throw(message="Password cannot be an empty string.");
		}

		var random = createObject("java","java.security.SecureRandom").getInstance("SHA1PRNG");
		var salt = createObject("java","java.nio.ByteBuffer").allocate(saltByteLength).array();
		random.nextBytes(salt);
		var derivedKeyLength = 160; /*this is the length of the sha1 hash */
		var spec = createObject("java","javax.crypto.spec.PBEKeySpec").init(password.toCharArray(), salt, iterations, derivedKeyLength);
		var keyFactory = createObject("java","javax.crypto.SecretKeyFactory").getInstance(algorithm);

		return {
			iterations = iterations,
			salt = binaryEncode(salt, "HEX"),
			hash = binaryEncode(keyFactory.generateSecret(spec).getEncoded(), "Hex")
		};
	}

	string function hashPassword (required string password, numeric iterations = 100000, numeric saltByteLength = 8) {
		var out = hashPasswordPBKDF2(argumentCollection=arguments);
		return out.iterations & ":" & out.salt & ":" & out.hash;
	}

	boolean function checkPassword (required string attemptedPassword, required string storedPassword) {
		var parts = listToArray(storedPassword, ":");

		if (arrayLen(parts) != 3) {
			throw(message="Invalid Stored Password, expected 3 parts separated by colon");
		}

		var iterations = parts[1];
		var salt = binaryDecode(parts[2], "Hex");
		var hash = binaryDecode(parts[3], "Hex");
		var spec = createObject("java","javax.crypto.spec.PBEKeySpec").init(attemptedPassword.toCharArray(), salt, iterations, arrayLen(hash) * 8);
		var keyFactory = createObject("java","javax.crypto.SecretKeyFactory").getInstance(algorithm);

		return compare(binaryEncode(keyFactory.generateSecret(spec).getEncoded(), "Hex"), parts[3]) == 0;
	}

}