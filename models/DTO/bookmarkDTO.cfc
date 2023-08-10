component name="BookmarkDTO" accessors="true" {

    // Properties
    property bookmark_id       type="string"  default="";
    property journal_id        type="string"  default="";
    property created_on        type="date"    default="";
    property modified_on       type="date"    default="";
    property bookmark_title    type="string"  default="";
    property url               type="string"  default="";
    property is_youtube_url    type="boolean";
    property short_description type="string"  default="";

    // Constructor
    public BookmarkDTO function init() {
        setBookmark_id	 	(createUUID());
        setJournal_id 	 	('');
		setBookmark_title	('');
        setShort_description('');
        setUrl				('');
        setIs_youtube_url	(false);
		setCreated_on		((isNull(this.created_on) || this.created_on EQ '') ? now() : this.created_on);
        setModified_on		(now());
        return this;
    }
}
