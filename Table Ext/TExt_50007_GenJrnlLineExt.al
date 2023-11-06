tableextension 50007 GenJrnlLineExt extends "Gen. Journal Line"
{
    fields
    {

        modify("Journal Batch Name")
        {
            trigger OnAfterValidate()
            begin
                if Rec."Journal Batch Name" = 'PAYROLL' then begin
                    Rec.Validate("Account Type", Rec."Account Type"::Employee);
                    Rec.Validate("Bal. Account Type", Rec."Bal. Account Type"::"Bank Account");
                end;
            end;
        }
        modify("Recipient Bank Account")
        {
            TableRelation = IF ("Account Type" = CONST(Vendor)) "Vendor Bank Account".Code WHERE("Vendor No." = FIELD("Account No."), Status = filter('Approved'));
        }
        field(50000; "EFT/Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'EFT/Document No.';
        }
        field(50029; "Vendor Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Type';
            OptionCaption = ' ,Advance Vendors,Normal Vendors';
            OptionMembers = " ","Advance Vendors","Normal Vendors";
        }
        ////neha 05012023
        field(50037; "Employment Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Sacco Deduction"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "Computer No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "PRDH_ID"; integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'PRDH_ID';
        }

        field(50002; "PR_MONTH"; integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'PR_MONTH';
        }

        field(50003; "PR_YEAR"; integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'PR_YEAR';
        }

        field(50004; "Status"; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(50005; "EmpId"; integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'EmpId';
        }
        field(50006; "Vote"; integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Vote';
        }

        field(50007; "TINNumber"; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'TINNumber';
        }
        field(50008; "SupplierNo"; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'SupplierNo';
        }
        field(50009; "NSSFNo"; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'NSSFNo';
        }
        field(50010; "ProgrammeCode"; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'ProgrammeCode';
        }
        field(50011; "PayrollNames"; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'PayrollNames';
        }
        field(50012; "IFMSNames"; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'IFMSNames';
        }
        field(50013; "Title"; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Title';
        }
        field(50014; "IFMSAccNo"; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'IFMSAccNo';
        }
        field(50015; "SalaryAccNo"; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'SalaryAccNo';
        }
        field(50016; "PayScale"; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'PayScale';
        }
        field(50017; "GrossPay"; decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'GrossPay';
        }
        field(50018; "BasicPay"; decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'BasicPay';
        }
        field(50019; "TaxableArreas"; decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'TaxableArreas';
        }
        field(50020; "TotalBasicPay"; decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'TotalBasicPay';
        }
        field(50021; "Paye"; decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Paye';
        }
        field(50022; "NSSF"; decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'NSSF';
        }
        field(50023; "LST"; decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'LST';
        }
        field(50024; "NetPay"; decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'NetPay';
        }
        /// 
        field(50025; "WHT Business Posting Group"; Code[20])
        {
            Caption = 'WHT Business Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Business Posting Group";
        }
        field(50026; "WHT Product Posting Group"; Code[20])
        {
            Caption = 'WHT Product Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Product Posting Group";
        }
        field(50027; "WHT Absorb Base"; Decimal)
        {
            Caption = 'WHT Absorb Base';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50028; "WHT Entry No."; Integer)
        {
            Caption = 'WHT Entry No.';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50030; "WHT Report Line No."; Code[20])
        {
            Caption = 'WHT Report Line No.';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50031; "Skip WHT"; Boolean)
        {
            Caption = 'Skip WHT';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }

        field(50032; "WHT Payment"; Boolean)
        {
            Caption = 'WHT Payment';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';

            trigger OnValidate()
            var

            begin
                ReadGLSetup;
                //IF NOT GLSetup."Manual Sales WHT Calc." THEN  //PRU_RPG WHT
                "WHT Payment" := FALSE;
            end;
        }
        field(50033; "Is WHT"; Boolean)
        {
            Caption = 'Is WHT';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50034; "Certificate Printed"; Boolean)
        {
            Caption = 'Certificate Printed';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50035; "Interest Amount"; Decimal)
        {
            Caption = 'Interest Amount';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';

            trigger OnValidate()
            var
                CurrExchRate: Record "Currency Exchange Rate";
            begin

                IF "Currency Code" = '' THEN
                    "Interest Amount (LCY)" := "Interest Amount"
                ELSE
                    "Interest Amount (LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Posting Date", "Currency Code",
                          "Interest Amount", "Currency Factor"));
            end;
        }
        field(50036; "Interest Amount (LCY)"; Decimal)
        {
            Caption = 'Interest Amount (LCY)';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
        field(50042; bankaccount; code[20])
        {
            TableRelation = "Bank Account";
            trigger OnValidate()
            begin
                "Bal. Account No." := bankaccount;
            end;
        }
    }
    var
        GLSetupRead: Boolean;
        GLSetup: Record "General Ledger Setup";
        CustText: Text[100];
        ApprovalEntry_Loc: Record "Approval Entry";
        CustRecordID: RecordId;
        Vendor_Loc: Record Vendor;

    local procedure ReadGLSetup()
    begin
        IF NOT GLSetupRead THEN BEGIN
            GLSetup.GET;
            GLSetupRead := TRUE;
        END;
    end;

    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create new General Journals');
        //PRU_DD 1.10
    end;

}