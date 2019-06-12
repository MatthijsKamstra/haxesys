package;

/**
 * Generated with HxJsonDef (version 0.0.8) on 2019-06-12 00:48:27
 * from : resume
 *
 * AST = Abstract Syntax Tree
 *
 * Note:
 * If you provide a .json there should be no null values
 * comments in this document show you the values that need to be changed!
 *
 * Some (backend)-developers choose to hide empty/null values, you can add them:
 * 		@:optional var _id : Int;
 *
 * Name(s) that you possibly need to change:
 * 		Location
 * 		Work
 * 		Languages
 * 		References
 * 		Interests
 * 		ResumeObjObj
 * 		Profiles
 * 		Volunteer
 * 		Awards
 * 		Education
 * 		Basics
 * 		Skills
 * 		Publications
 */

typedef Resume = {
	var basics : Basics;
	var work : Work;
	var volunteer : Volunteer;
	var education : Education;
	var awards : Awards;
	var publications : Publications;
	var skills : Skills;
	var languages : Languages;
	var interests : Interests;
	var references : References;
}

typedef Location =
{
	var city : String;
	var postalCode : String;
	var countryCode : String;
	var region : String;
	var address : String;
};

typedef Work =
{
	var position : String;
	var website : String;
	var highlights : Array<String>;
	var startDate : String;
	var summary : String;
	var company : String;
	var endDate : String;
};

typedef Languages =
{
	var fluency : String;
	var language : String;
};

typedef References =
{
	var name : String;
	var reference : String;
};

typedef Interests =
{
	var name : String;
	var keywords : Array<String>;
};

typedef ResumeObjObj =
{
	var education : Array<Education>;
	var work : Array<Work>;
	var basics : Basics;
	var languages : Array<Languages>;
	var skills : Array<Skills>;
	var volunteer : Array<Volunteer>;
	var awards : Array<Awards>;
	var references : Array<References>;
	var publications : Array<Publications>;
	var interests : Array<Interests>;
};

typedef Profiles =
{
	var network : String;
	var url : String;
	var username : String;
};

typedef Volunteer =
{
	var organization : String;
	var position : String;
	var website : String;
	var highlights : Array<String>;
	var startDate : String;
	var summary : String;
	var endDate : String;
};

typedef Awards =
{
	var date : String;
	var awarder : String;
	var summary : String;
	var title : String;
};

typedef Education =
{
	var area : String;
	var institution : String;
	var startDate : String;
	var gpa : String;
	var studyType : String;
	var courses : Array<String>;
	var endDate : String;
};

typedef Basics =
{
	var phone : String;
	var name : String;
	var location : Location;
	var profiles : Array<Profiles>;
	var label : String;
	var email : String;
	var website : String;
	var picture : String;
	var summary : String;
};

typedef Skills =
{
	var name : String;
	var level : String;
	var keywords : Array<String>;
};

typedef Publications =
{
	var publisher : String;
	var name : String;
	var releaseDate : String;
	var website : String;
	var summary : String;
};
