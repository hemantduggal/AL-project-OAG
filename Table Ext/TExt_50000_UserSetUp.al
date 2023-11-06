tableextension 50000 UserSetupExt extends "User Setup"
{
    fields
    {
        field(50000; "Access Requisition Document"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50001; "BlanketPurchaseOrder"; Option)
        {
            DataClassification = ToBeClassified;
            caption = 'Blanket Purchase Order (Contract Order)';
            OptionCaption = ',Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50002; "Phys.Inventory Journals"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
            Caption = 'Phys. Inventory Journals';
        }
        field(50003; "Bank Master"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Create,Edit,View,Blocked';
            OptionMembers = " ",Create,Edit,View,Blocked;
        }
        field(50004; "Employee Master"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50005; "AccessFixedAssetsMaster"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
            Caption = 'Access Fixed Assets Master';

        }
        field(50006; "DepreciationCalandPosting"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
            Caption = 'Depreciation Calculation and Posting';
        }
        field(50007; "Disposal Posting"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50008; "AccessPOTerms&ConditionMaster"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
            Caption = 'Access PO Terms & Condition Master';
        }
        field(50009; "HO Users"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50010; "Budget"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50011; "VAT Setup"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        /* field(50012; "WHT Setup"; Option)
         {
             DataClassification = ToBeClassified;
             OptionCaption = ',Create,Edit,View';
             OptionMembers = " ",Create,Edit,View;
         }*/
        field(50013; Currencies; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50014; "Access Purchase Invoice"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50015; "Access Purchase Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50016; "Access Sales Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Ship,Invoice,Ship & Invoice';
            OptionMembers = " ",Edit,View,Ship,Invoice,"Ship & Invoice";
        }
        field(50017; "Access Sales Return Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Receive,Invoice,Receive & Invoice';
            OptionMembers = " ",Edit,View,Receive,Invoice,"Receive & Invoice";
        }
        field(50018; "Access Sales Invoice"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50019; "Access Item Master"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50020; "Access Customer Master"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50021; "Access Vendor Master"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50022; "Adjust Exchange Rates"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50023; "Access Sales Credit Memo"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50024; "Access Purchase Credit Memo"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50025; "Access Purchase Return Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50026; "YearEndBooking Closing"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Year End Booking Closing';
            OptionCaption = ' ,Post';
            OptionMembers = " ",Post;
        }
        field(50027; "Accounting Periods"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Accounting Periods';
            OptionCaption = ',Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50028; "Chart of Account"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50029; "Dimension Values"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50030; "AccessNo.Series"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Access No. Series(Master & Doc series)';
            OptionCaption = ',Create,View';
            OptionMembers = " ",Create,View;
        }
        field(50031; "G/L Register"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',View';
            OptionMembers = " ",View;
        }
        field(50032; "Item Ledger Entry"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',View';
            OptionMembers = " ",View;
        }
        field(50033; "Access Location Master"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Edit,View,Create';
            OptionMembers = " ",Edit,View,Create;
        }
        field(50034; "Vendor Ledger Entry"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',View';
            OptionMembers = " ",View;
        }
        field(50035; "Customer Ledger Entry"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ',View';
            OptionMembers = " ",View,Post;
        }
        field(50036; "EMP.Ledger Entry"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ',View';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50037; "Bank Ledger Entry"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ',View';
            OptionMembers = " ",View;
        }//neha
        field(50038; "Access Purchase Journal"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50039; "Access Sales Journal"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50040; "Access Cash Receipt Voucher"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50041; "Access Bank Receipt Voucher"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50042; "Access Payment Journal"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50043; "Access Cash Payment Voucher"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50044; "Access Bank Payment Voucher"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50045; "Access General Journals"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50046; "Access Journal Voucher"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50047; "Access Contra Voucher"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50048; "Access Ship to Address"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit';
            OptionMembers = " ",Create,View,Edit;
        }
        field(50049; "Access Breed Master"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View';
            OptionMembers = " ",Edit,View;
        }
        field(50050; "Access Data Entry Sheet"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50051; "Access Hatchry Entry Sheet"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50052; "Access Parameter List"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50053; "Access Template Master"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50054; "Access Item Reclass"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50055; "Access Bank Rec."; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50057; "Access Purchase Quote"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50058; "Access Gate In & Gate Out"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50059; "Access Indent"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Close,Reopen,Approve';
            OptionMembers = " ",Create,Edit,View,Close,Reopen,Approve;
        }
        field(50060; "Access Normal GC Statement"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit,Calculate';
            OptionMembers = " ",Create,View,Edit,Calculate;
        }
        field(50061; "Access EC GC Statement"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit,Calculate';
            OptionMembers = " ",Create,View,Edit,Calculate;
        }
        field(50062; "Access RGP"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit,Post';
            OptionMembers = " ",Create,View,Edit,Post;
        }
        field(50063; "Access NRGP"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit,Post';
            OptionMembers = " ",Create,View,Edit,Post;
        }
        field(50064; "Access Item Journal"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit,Post';
            OptionMembers = " ",Create,View,Edit,Post;
        }
        field(50065; "Access Transfer Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit,Post';
            OptionMembers = " ",Create,View,Edit,Post;
        }
        field(50066; "Access Prod. BOM"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit';
            OptionMembers = " ",Create,View,Edit;
        }
        field(50067; "Access R Prod. Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit,Convert';
            OptionMembers = " ",Create,View,Edit,Convert;
        }
        field(50068; "Access Work Center"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit';
            OptionMembers = " ",Create,View,Edit;
        }
        field(50069; "Access Machine Center"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit';
            OptionMembers = " ",Create,View,Edit;
        }
        field(50070; "Access Routing"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit';
            OptionMembers = " ",Create,View,Edit;
        }
        field(50071; "Access Bank Account"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit';
            OptionMembers = " ",Create,View,Edit;
        }
        field(50072; "Access GL Setup"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View';
            OptionMembers = " ",Edit,View;
        }
        field(50073; "Access User Setup"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50074; "Access User"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50075; "Access FA G/L Journals"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }///need to ask
        field(50076; "Access FA Journals"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50077; "TO Post With Prod.Order"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-GK 1.10';
        }
        field(50078; "Liquidation Date"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-GK 1.10';
        }
        field(50079; "Edit Flock No. ILE"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50080; "Reverse Transaction"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-AB';
        }
        field(50081; Department; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Accounts,Sales,Production,Auditor,Purchase,Finance,IT,HR';
            OptionMembers = " ",Accounts,Sales,Production,Auditor,Purchase,Finance,IT,HR;
        }
        field(50082; "Access G\L Account"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50083; "User Permission"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50085; "Date Freeze"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

            end;
        }
        field(50086; "Day Aceess"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50087; "CBF Line No."; Code[10])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Line Name (CBF)"."Line Code";
        }
        field(50088; "Short Close"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50127; "WHT Business Posting Group"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50128; "WHT product Posting Group"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50129; "WHT Setup"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50130; storeuser; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Store User';
        }
        field(50131; accountuser; Boolean)
        {
            DataClassification = ToBeClassified;
            // Caption = 'Store User';
        }
        field(50132; delegate; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
            // Caption = 'Store User';
        }
        field(50133; faclass; Boolean)
        {
            DataClassification = ToBeClassified;
            // Caption = 'Store User';
        }
        field(50134; ChangeCurrency; Boolean)
        {
            DataClassification = ToBeClassified;
            // Caption = 'Store User';
        }
        field(50135; payrollnotification; Boolean)
        {
            DataClassification = ToBeClassified;
            // Caption = 'Store User';
        }
    }

    procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode); //TRI
    end;
}