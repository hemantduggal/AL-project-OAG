tableextension 50003 PurcHeaderExt extends "Purchase Header"
{
    fields
    {
        field(50000; "Purchase Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Type';
            OptionCaption = ' ,Micro,Macro';
            OptionMembers = " ",Micro,Macro;
        }
        field(50001; "Requisition Slip No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Requisition No.';
            TableRelation = "purchase Requisition Header";

            trigger OnValidate() ///neha
            var
                reqH: Record "purchase Requisition Header";
            begin
                if reqH.get(rec."Requisition Slip No.") then
                    rec."Reference No." := reqH."Reference No.";
            end;
        }
        field(50002; "Reference No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reference No.';
        }
        field(50003; "Details T&C (Attach)"; text[2047])
        {
            DataClassification = ToBeClassified;
            Caption = 'Details T&C (Attach)';
        }
        field(50004; "General T&C"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'General T&C';
            TableRelation = "Terms and  Condition".Code;
        }
        field(50005; "Special T&C "; text[2047])
        {
            DataClassification = ToBeClassified;
            Caption = 'Special T&C ';
        }
        field(50006; "Store Admin Comment"; text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Store Admin Comment';
        }
        field(50007; "Store_Visual Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';
        }
        field(50008; Store_Accepted; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Accepted';
            trigger OnValidate()
            begin
                if Store_Accepted = true then
                    Store_Rejected := false;
                if Store_Accepted = false then
                    Store_Rejected := true;
            end;
        }
        field(50009; Store_Rejected; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rejected';
            trigger OnValidate()
            begin
                if Store_Rejected = true then
                    Store_Accepted := false;
                if Store_Rejected = false then
                    Store_Accepted := true;
            end;
        }
        field(50010; "Store_File Attachment Link"; text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'File Attachment Link';
        }
        field(50011; "Short Close"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Short Close';
        }
        field(50012; "Subject of Procurement"; text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Subject of Procurement';
        }

        field(50013; "Contract Admin Comment"; text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Comment';
        }
        field(50014; "Contract_Visual Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';
        }
        field(50015; Contract_Accepted; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Accepted';
            trigger OnValidate()
            begin
                if Contract_Accepted = true then
                    Contract_Rejected := false;
                if Contract_Accepted = false then
                    Contract_Rejected := true;
            end;
        }
        field(50016; Contract_Rejected; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rejected';
            trigger OnValidate()
            begin
                if Contract_Rejected = true then
                    Contract_Accepted := false;
                if Contract_Rejected = false then
                    Contract_Accepted := true;
            end;
        }
        field(50017; "Contract_File Attachment Link"; text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'File Attachment Link';
        }

        field(50018; "Internal Admin Comment"; text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Internal Comment';
        }
        field(50019; "Internal_Visual Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';
        }
        field(50020; Internal_Accepted; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Accepted';
            trigger OnValidate()
            begin
                if Internal_Accepted = true then
                    Internal_Rejected := false;
                if Internal_Accepted = false then
                    Internal_Rejected := true;
            end;
        }
        field(50021; Internal_Rejected; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rejected';
            trigger OnValidate()
            begin
                if Internal_Rejected = true then
                    Internal_Accepted := false;
                if Internal_Rejected = false then
                    Internal_Accepted := true;
            end;
        }
        field(50022; "Internal_File Attachment Link"; text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'File Attachment Link';
        }
        field(50029; "Vendor Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Type';
            OptionCaption = ' ,Advance Vendors,Normal Vendors,Staff';
            OptionMembers = " ","Advance Vendors","Normal Vendors","Staff";
        }
        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            var
                recv: record vendor;
            begin
                if recv.get("Buy-from Vendor No.") then begin
                    if recv.status <> recv.status::Approved then
                        Error('Vendor is not approved.');
                    "Vendor Type" := recv."Vendor Type";
                    "WHT Business Posting Group" := recv."WHT Business Posting Group";//neha
                end;
            end;
        }
        field(50030; "WHT Business Posting Group"; Code[20])//
        {
            Caption = 'WHT Business Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Business Posting Group";
        }
        field(50031; "Actual Vendor No."; Code[20])
        {
            Caption = 'Actual Vendor No.';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = Vendor;
        }
        field(50040; "approver's comment"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50041; expirydate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50042; StoreApprover; CODE[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(50043; ContractorApprover; Code[20])

        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(50044; InternalApprover; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(50045; encumdate; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to create Purchase Credit Memo');
        END;
        //PRU_DD 1.10
        IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup.BlanketPurchaseOrder, '%1', UserSetup.BlanketPurchaseOrder::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to create Purchase Credit Memo');
        END;

        IF "Document Type" = "Document Type"::Invoice THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Purchase Invoice", '%1', UserSetup."Access Purchase Invoice"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to create Purchase Invoice');
        END;
        //PRU_DD 1.10

        IF "Document Type" = "Document Type"::Order THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to create Purchase Order');
        END;
        //PRU_DD 1.10

        IF "Document Type" = "Document Type"::Quote THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to create Purchase Quote');
        END;
        //PRU_DD 1.10

        IF "Document Type" = "Document Type"::"Return Order" THEN BEGIN
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have Permission to create Purchase Return Order');
        END;
        //PRU_DD 1.10
    end;


    var


}