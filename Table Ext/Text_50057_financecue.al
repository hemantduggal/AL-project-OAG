tableextension 50059 finance extends "Finance Cue"
{
    fields
    {
        field(50000; Notifications; Integer)
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            Description = 'Lomesh_0.1';
            CalcFormula = Count(Notifications where("User ID" = field("User Id")));
        }
        field(50001; "User Id"; code[64])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Session."User ID" WHERE("My Session" = filter(true)));
        }
    }
}