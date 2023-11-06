Tableextension 50061 fareclass extends "FA Reclass. Journal Batch"

{
    fields
    {
        field(50000; "Status"; Option)
        {
            OptionMembers = Open,Approved,Rejected,"Pending For Approval";
            DataClassification = ToBeClassified;
            // FieldClass = FlowField;
            Description = 'Lomesh_0.1';
        }
    }
}