table 50017 "Approval Entry requistion"
{
    Caption = 'Approval Entry';
    ReplicateData = true;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
        }
        field(2; "Document Type"; Enum "Approval Document Type")
        {
            Caption = 'Document Type';
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; description; text[250])
        {
            Caption = 'Approval Code';
        }
        field(5; "Sender ID"; Code[50])
        {
            Caption = 'Sender ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(6; "Approver ID 1"; Code[50])
        {
            Caption = 'Approver ID 1';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(7; Comment1; text[100])
        {
            Caption = '1st approval Comment';
            Editable = false;
        }
        field(8; "Approver ID 2"; Code[50])
        {
            Caption = 'Approver ID 2';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(9; Status; code[40])
        {
            Caption = 'Status';
        }
        field(10; "Date-Time Sent for Approval"; DateTime)
        {
            Caption = 'Date-Time Sent for Approval';
        }
        field(11; "Last Date-Time Modified"; DateTime)
        {
            Caption = 'Last Date-Time Modified';
        }
        field(12; "Last Modified By User ID"; Code[50])
        {
            Caption = 'Last Modified By User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(13; Comment2; text[250])
        {
            Caption = '2nd approval Comment';
            Editable = false;
        }
        field(22; "Record ID to Approve"; RecordID)
        {
            Caption = 'Record ID to Approve';
            DataClassification = CustomerContent;
        }
        field(29; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Date-Time Sent for Approval" := CurrentDateTime;
        "Last Date-Time Modified" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        "Last Date-Time Modified" := CurrentDateTime;
    end;
}

