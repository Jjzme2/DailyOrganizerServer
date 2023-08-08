/**
 * This will be the service that will handle all the BASE SERVER(SERVICE) functions.
 * @Authors Jj Zettler
 * @date 7/25/2023
 * @version 0.1
 */
component singleton accessors="true" name="BaseServer" {

	property name="calculator" inject="MathService";
	property name="responder"  inject="ResponseService";

	public any function init ()
	{
		return this;
	}

	public string function GetType()
	{
		return this.type;
	}
}