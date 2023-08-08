component name="MarkdownGenerationService" {
	property name="logService" inject="Logger";

	// Set default values
	variables.defaultOutputDirectory = Expandpath("/assets/docs/generated/markdown/");
	<!--- ---------------------------- GETTERS ---------------------------- --->

	/**
		* Gets the default output directory
		* @return string
	*/
	public string function getFullPathToMarkdownFile(required string fileName, string directory)
	{
		var directoryArgPassedIn = StructKeyExists(arguments, "directory") && len(trim(arguments.directory));

		if(!directoryArgPassedIn)
		{
			arguments.directory = variables.defaultOutputDirectory;
		}else{
			// Use the default directory as the parent
			arguments.directory = variables.defaultOutputDirectory & arguments.directory;

		}

		return arguments.directory & arguments.fileName & ".md";
	}

	/**
		* Gets a template of a Title for a markdown File
		* @param contentToAdd - The content to add to the title
		* @param level - The level of the title (1, 2, 3)
		* @param applyStyle - Whether or not to apply the style to the title
		* @return string
	*/
	public string function getTitleFromContent(required string contentToAdd, required number level, boolean applyStyle=true)
	{
		var content =  chr(35) & " " & contentToAdd;
		var idAttribute = " id='" & replace(contentToAdd, " ", "-", "all") & "' ";
		var classAttribute = '';

		switch(level){
			case 1:
				classAttribute="class='title'";
				break;
			case 2:
				classAttribute="class='sub-title'";
				break;
			case 3:
				classAttribute="class='tri-title'";
				break;
			default:
				code;
			break;
		}


		if (applyStyle) {
			content &= " {" & idAttribute & classAttribute & "}" & chr(10);
		} else {
			content &= " {" & idAttribute & "}" & chr(10);
		}

		return content;
	}

	/**
		* Gets a template of a link for a markdown File
		* @param contentToAdd - The content to add to the link
		* @param link - The link to add to the link
		* @return string
	*/
	public string function getLinkFromContent(required struct content)
	{
		if(structKeyExists(arguments.content, "title") && structKeyExists(arguments.content, "link")){
			var content = "[" & arguments.content.title & "](" & arguments.content.link & ")" & chr(10);
		}else{
			cfabort(showerror='Please make sure #arguments.content# struct contains both a title and a link');
		}
		return content;
	}

	/**
		* Gets a template of a code block for a markdown File
		* @param contentToAdd - The content to add to the code block
		* @param codeType - The type of code block to add (inline, block)
		* @param language - The language of the code block
		* @return string
	*/
	public string function getCodeFromContent(required string contentToAdd, string codeType='inline', language='')
	{
		var acceptedCodeTypes = ['inline', 'block'];
		var content = "";
		if(arrayFind(acceptedCodeTypes, arguments.codeType)){
			if(arguments.codeType == "inline"){
				content = "`" & arguments.contentToAdd & "`" & chr(10);
			}else{
				content = "```" & arguments.language & chr(10) & arguments.contentToAdd & chr(10) & "```" & chr(10);
			}
		}else{
			throw(message="Code type (#arguments.codeType#) not accepted", detail="Code type not accepted", type="CodeTypeNotAccepted");
		}
		return content;
	}

	/**
		* Gets a template of a List for a markdown File
		* @param listItems - The array of items to add to the list
		* @param listType - The type of List to add (ordered, unordered)
		* @return string
	*/
	public string function getListFromContent(required array listItems, string listType="o")
	{
		var references = {
			'ordered': [
				'ordered',
				'numbered',
				'o',
				'ord'
			],
			'unordered': [
				'unordered',
				'bullet',
				'u',
				'unord'
			]
		};

		var content = "";
		var listType = listType.toLowerCase();

		cfabort(showerror=ArrayToList(listItems));

		if (arrayFindNoCase(references.ordered, listType)) {
			for(i=1; i<=arrayLen(arguments.listItems); i++){
				content &= "1. " & arguments.listItems[i] & chr(10);
			}
		} else if (arrayFindNoCase(references.unordered, listType)) {
			for(i=1; i<=arrayLen(arguments.listItems); i++){
				content &= "- " & arguments.listItems[i] & chr(10);
			}
		} else {
			throw(message="List type not accepted", detail="List type not accepted", type="ListTypeNotAccepted");
		}

		return content;
	}

	<!--- ---------------------------- FUNCTIONS ---------------------------- --->

	public function createNewMarkdownFile(required string fileName, string directory)
	{
		var directoryArgPassedIn = StructKeyExists(arguments, "directory") && len(trim(arguments.directory));

		if(!directoryArgPassedIn)
		{
			arguments.directory = variables.defaultOutputDirectory;
		}else{
			// Use the default directory as the parent
			arguments.directory = variables.defaultOutputDirectory & "/" & arguments.directory;
		}

		if(!DirectoryExists(arguments.directory))
		{
			logService.sendSimpleLog(message="Directory does not exist, creating it now", prefix="Services_MDGen");
			DirectoryCreate(arguments.directory);
		}

		// Check if the file already exists
		if(FileExists(arguments.directory & "/" & arguments.fileName))
		{
			throw(message="File already exists", detail="File already exists", type="FileAlreadyExists");
		}else{
			// Create the file
			fileWrite(arguments.directory & "/" & arguments.fileName & ".md", "");
		}
	}

	private function appendToFile(required string fileName, required string content, boolean createIfNA=false)
	{
		if(createIfNA){
			if(!FileExists(arguments.fileName))
			{
				createNewMarkdownFile(fileName=arguments.fileName);
			}
		}else if(!FileExists(arguments.fileName)){
				throw(message="(" & fileName & ")" & " does not exist.", detail=fileName & " does not exist.", type="FileDoesNotExist")
		}

		fileAppend(arguments.fileName, arguments.content);
	}




}
