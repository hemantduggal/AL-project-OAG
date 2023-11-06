pageextension 50042 PurchaseOrderSubformExt extends "Purchase Order Subform"
{
    layout
    {
        modify(Type)
        {
            trigger OnAfterValidate()
            begin

            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                if Rec.Type = rec.Type::"Fixed Asset" then begin
                    Rec.validate(Quantity, 1);
                    rec.Modify();
                end;
            end;
        }
        modify("Location Code")
        {
            ShowMandatory = true;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                if Rec.Type = rec.Type::"Fixed Asset" then begin
                    Rec.TestField(Quantity, 1);
                end;
            end;
        }
        addbefore("Qty. to Receive")
        {
            field("Amount Inc VAT"; Rec."Amount Inc VAT")
            {
                ApplicationArea = all;
            }
        }
        addafter("Line No.")
        {
            field("WHT Business Posting Group"; rec."WHT Business Posting Group")
            {
                Applicationarea = All;
            }
            field("WHT Product Posting Group"; rec."WHT Product Posting Group")
            {
                Applicationarea = All;
            }
            field("WHT Absorb Base"; rec."WHT Absorb Base")
            {
                Applicationarea = All;
            }
        }
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify("Over-Receipt Quantity")
        {
            Visible = false;
        }
    }
    trigger OnOpenPage()
    var
        ph: Record "Purchase Header";
    begin
        ph.Reset();
        ph.SetRange("No.", Rec."Document No.");
        if ph.FindFirst() then
            if ph.Status = ph.Status::"Pending Approval" then
                CurrPage.Editable := false
            else
                CurrPage.Editable := True;
    end;

    trigger OnDeleteRecord(): Boolean
    var

    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete Purchase Order');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to insert Purchase Order');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to modify Purchase Order');
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        edita: Boolean;
}