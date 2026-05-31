<cfscript>
/**
// From https://cflib.org/udf/formatJSON with correction from "Mary" and "Mr Namako" shown on cflib.org plus additional updates by John Bartlett:
*	Do not add line feeds after escaped quotes
*	Hanlde large JSON by splitting up the return string into two variables due esponently longer processing on appending onto larger strings
*	Ignore JSON characters if inside a quoted string
* Formats a JSON string with indents &amp; new lines.
* v1.0 by Ben Koshy
*
* @param str      JSON string (Required)
* @return Returns a string of indent-formated JSON
* @author Ben Koshy (cf@animex.com)
* @version 0, September 16, 2012
*/
// formatJSON() :: formats and indents JSON string
// based on blog post @ http://ketanjetty.com/coldfusion/javascript/format-json/
// modified for CFScript By Ben Koshy @animexcom
// usage: result = formatJSON('STRING TO BE FORMATTED') OR result = formatJSON(StringVariableToFormat);

public string function formatJSON(instr) {
	var str=arguments.instr;
	var fjson = '';
	var fjson2 = '';
	var pos = 0;
	var strLen = 0;
	var indentStr = chr(9); // Adjust Indent Token If you Like
	var newLine = chr(10); // Adjust New Line Token If you Like <BR>
	var InQuote=0;

	if (IsJSON(str) EQ "NO") return "Not a JSON object";

	str=Replace(str,"(?<!\\)(?:\\\\)*\\""",Chr(2),"All"); // Replace escaped quotes with a placeholder so they are not processed in the loop but not where a escaped backslash at the end of a text string
	strLen = len(str);

	for (var i=1; i<=strLen; i++) {
		var char = mid(str,i,1);
		if (char EQ Chr(34)) {
			// Flag if inside a quote or not
			InQuote = 1 - InQuote;
		}

		if (char == '}' || char == ']') {
			if (InQuote EQ 0) {
				fjson &= newLine;
				pos = pos - 1;

				for (var j=1; j<=pos; j++) {
					fjson &= indentStr;
				}
			}
		}

		fjson &= char;

		//if (char == '{' || char == '[' || (char == ',' && InQuote EQ 0)) {
		if (ListFind(",|{|[",char,"|") AND InQuote EQ 0) {
			fjson &= newLine;

			if (char == '{' || char == '[') {
				pos = pos + 1;
			}

			for (var k=1; k<=pos; k++) {
				fjson &= indentStr;
			}
		}

		if (Len(fjson) GTE 10240) {
			fjson2=fjson2 & fjson;
			fjson="";
		}
	}

	str=Replace(str,Chr(2),"\""","All"); // Replace placeholder with original escaped quotes

	return fjson2 & fjson;
}
</cfscript>
