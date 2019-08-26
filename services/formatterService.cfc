component accessors=true singleton=true {

	string function formatDate (required date input) {
		if (dateCompare(input, getSetting("never")) != 0) {
			return dateFormat(input, getSetting("dateFormatMask"));
		}

		return '';
	}

	string function formatTime (required date input) {
		if (dateCompare(input, getSetting("never")) != 0) {
			return timeFormat(input, getSetting("timeFormatMask"));
		}

		return '';
	}

	string function formatDateTime (required date input) {
		return formatDate(input) & " " & formatTime(input);
	}

	string function formatPhone (required string input) {
		var numbersOnly = reReplaceNoCase(trim(input),"[^0-9]","","all");

		if (len(numbersOnly) == 10) {
			return "(" & mid(numbersOnly, 1, 3) & ") " & mid(numbersOnly, 4, 3) & "-" & mid(numbersOnly, 7, 4);
		} else if (len(numbersOnly) == 7) {
			return mid(numbersOnly, 1, 3) & "-" & mid(numbersOnly, 4, 4);
		}

		return input;
	}

	string function sesify (required string input) {
		//based on http://cflib.org/udf/toFriendlyURL

		var diacritics = [
			[chr(225) & chr(224) & chr(226) & chr(229) & chr(227) & chr(228), "a"],
			[chr(230), "ae"],
			[chr(231), "c"],
			[chr(233) & chr(232) & chr(234) & chr(235), "e"],
			[chr(237) & chr(236) & chr(238) & chr(239), "i"],
			[chr(241), "n"],
			[chr(243) & chr(242) & chr(244) & chr(248) & chr(245) & chr(246), "o"],
			[chr(223), "B"],
			[chr(250) & chr(249) & chr(251) & chr(252), "u"],
			[chr(255), "y"],
			[chr(193) & chr(192) & chr(194) & chr(197) & chr(195) & chr(196), "A"],
			[chr(198), "AE"],
			[chr(199), "C"],
			[chr(201) & chr(200) & chr(202) & chr(203), "E"],
			[chr(205) & chr(204) & chr(206) & chr(207), "I"],
			[chr(209), "N"],
			[chr(211) & chr(210) & chr(212) & chr(216) & chr(213) & chr(214), "O"],
			[chr(218) & chr(217) & chr(219) & chr(220), "U"]
		];

		// replace diacritics with plausible ascii substitutes


		for(var dia in diacritics){
			str = ReReplace(input, "[#dia[1]#]", dia[2], "all");
		}

		// make it all lower case
		input = trim(lcase(input));
		// replace consecutive spaces and dashes and underscores with a single dash
		input = ReReplace(input, '[\s\-_]+', '-', 'all');
		// remove dashes at the beginning or end of the string
		input = ReReplace(input, '(^\-+)|(\-+$)', '', 'all');
		// replace ampersand with and
		input = ReReplace(input, '&', 'and', 'all');
		input = ReReplace(input, '&.*?;', '', 'all');
		input = ReReplace(input, '&', 'and', 'all');
		// remove any remaining non-word chars
		input = ReReplace(input, "[^a-zA-Z0-9\-]", "", "all");

		return input;
	}

	function paragraphFormat2(str) {
		//first make Windows style into Unix style
		str = replace(str,chr(13)&chr(10),chr(10),"ALL");
		//now make Macintosh style into Unix style
		str = replace(str,chr(13),chr(10),"ALL");
		//now fix tabs
		str = replace(str,chr(9),"&nbsp;&nbsp;&nbsp;","ALL");
		//now return the text formatted in HTML
		return replace(str,chr(10),"<br />","ALL");
	}

}

