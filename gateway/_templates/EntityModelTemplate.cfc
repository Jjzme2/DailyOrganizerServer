/* --------------------------------------------------------
   BaseModel.cfc
   Description: A base model for common properties and methods used in entities.
   -------------------------------------------------------- */

component {

  /* --------------------------------------------------------
     Properties
     -------------------------------------------------------- */

  property name="id" type="string" default="";
  property name="name" type="string" default="";

  /* --------------------------------------------------------
     Public Functions
     -------------------------------------------------------- */

  /**
   * Constructor to create a new BaseModel instance.
   * @name The name of the entity.
   */
  public function init(name) {
    variables.name = arguments.name;
    return this;
  }

  /**
   * Get the entity's ID.
   * @return The entity's ID.
   */
  public string function getId() {
    return variables.id;
  }

  /**
   * Get the entity's name.
   * @return The entity's name.
   */
  public string function getName() {
    return variables.name;
  }

  // Add more common properties and methods that can be used for this template.

}
