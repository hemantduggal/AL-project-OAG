tableextension 50002 DimensionValue extends "Dimension Value"
{
    fields
    {
        field(50000; "Dimension Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Dimension Type';
            OptionCaption = ' ,Funding Source,Programme,Directorate and Department,Project,Budget Output,Audit Entities and Audit Projects';
            OptionMembers = " ","Funding Source",Programme,"Directorate and Department",Project,"Budget Output","Audit Entities and Audit Projects";

        }
        field(50001; "Recurring Projects"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Accounting Year"; text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = CodeType_AccountingPeriod."Dimension Financial Year";
            ;
        }
    }

    var

}