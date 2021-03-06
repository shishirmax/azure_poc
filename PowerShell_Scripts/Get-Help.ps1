TOPIC
    Get-Help

SHORT DESCRIPTION
    Displays help about Windows PowerShell cmdlets and concepts. 

LONG DESCRIPTION

SYNTAX
    get-help {<CmdletName> | <TopicName>}
    help {<CmdletName> | <TopicName>}
    <CmdletName> -?

    "Get-help" and "-?" display help on one page. 
    "Help" displays help on multiple pages.
	
    Examples:
      get-help get-process   : Displays help about the Get-Process cmdlet.
      get-help about_signing : Displays help about signing scripts.
      help where-object      : Displays help about the Where-Object cmdlet.
      help about_foreach     : Displays help about foreach loops in PowerShell.
      set-service -?         : Displays help about the Set-Service cmdlet.

    You can use wildcard characters in the help commands (not with -?). 
    If multiple help topics match, PowerShell displays a list of matching 
    topics. If only one help topic matches, PowerShell displays the topic. 

    Examples:
      get-help *      : Displays all help topics.
      get-help get-*  : Displays topics that begin with get-.
      help *object*   : Displays topics with "object" in the name.       
      get-help about* : Displays all conceptual topics.


    For information about wildcards, type:
      get-help about_wildcard


REMARKS
    To learn about Windows PowerShell, read the following help topics:
      get-command  : Gets information about cmdlets from the cmdlet code.
      get-member   : Gets the properties and methods of an object.
      where-object : Filters object properties.
      about_object : Explains the use of objects in Windows PowerShell.
      about_remote : Tells how to run commands on remote computers.  

    Conceptual help files are named "about_<topic>", such as: 
      about_regular_expression.

    The names of conceptual help files must be entered in English
    even on non-English versions of Windows PowerShell.
	
    The help commands also display the aliases of the cmdlets. These
    are alternate names or nicknames that are often easier to type.
    For example, the alias for the Invoke-Command cmdlet is "remote".

    To get the aliases, type: 
	
      get-alias
