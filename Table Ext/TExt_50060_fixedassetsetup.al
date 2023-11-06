tableextension 50060 fasetup extends "FA Setup"
{
    fields
    {
        field(50000; "Reclassification User Group"; code[40])
        {
            DataClassification = ToBeClassified;
            // FieldClass = FlowField;
            Description = 'Lomesh_0.1';
            TableRelation = "Workflow User Group";
        }
    }
}