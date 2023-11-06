tableextension 50006 VendorBankAccExt extends "Vendor Bank Account"
{
    fields
    {
        field(50000; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Created By';
        }
        field(50001; "Created Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Created Date';
        }
        field(50002; "Last Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Modified By';
        }
        field(50003; "Last Modified Date"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Last Modified Date';
        }
        field(50004; Status; Option)
        {
            Editable = false;
            OptionCaption = ' ,Released,Open,Rejected,"Pending For Approval"';
            OptionMembers = " ",Released,Open,Rejected,"Pending For Approval";
            DataClassification = ToBeClassified;
        }

    }
    trigger OnAfterInsert()
    begin
        "Created Date" := CurrentDateTime();
        "Created By" := UserId;
    end;

    trigger OnInsert()
    var
        VenBankAcc: Record "Vendor Bank Account";
    begin
        "Created Date" := CurrentDateTime();
        "Created By" := UserId;
        "Last Modified Date" := CurrentDateTime();
        "Last Modified By" := UserId;

    end;

    trigger OnModify()
    var
        VenBankAcc: Record "Vendor Bank Account";
    begin
        "Last Modified Date" := CurrentDateTime();
        "Last Modified By" := UserId;

    end;

    var

}