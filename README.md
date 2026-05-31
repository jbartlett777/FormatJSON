# FormatJSON
Formats a JSON string into human readable format

cflib.org is in a read-only state so sharing the function here with updates to handle issues not covered in the original function.

### Sample Code
```
<cfset jsonString='{key1:"string value",key2:["array","of","elements"],key3:123,key4:{key5:50,key6:"string"}}'>
<pre>
<cfoutput>#formatJSON(jsonString)#</cfoutput>
</pre>
```
### Output
```
{
	"key1":"string value",
	"key2":[
		"array",
		"of",
		"elements"
	],
	"key3":123,
	"key4":{
		"key5":50,
		"key6":"string"
	}
}
```
