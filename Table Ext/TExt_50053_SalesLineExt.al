tableextension 50053 SaleslineExt1 extends "Sales Line"
{
    fields
    {
        field(50012; "WHT Business Posting Group"; Code[20])
        {
            Caption = 'WHT Business Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Business Posting Group";
        }
        field(50013; "WHT Product Posting Group"; Code[20])
        {
            Caption = 'WHT Product Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Product Posting Group";
        }
        field(50014; "WHT Absorb Base"; Decimal)
        {
            Caption = 'WHT Absorb Base';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
    }
    var
        ItemCharge: Record "Item Charge";

    local procedure CopyFromItem()
    var
        Item: Record 27;
        PrepaymentMgt: Codeunit 441;
    begin
        "WHT Product Posting Group" := Item."WHT Product Posting Group";  //PRU_RPG WHT_0.1
    end;

    local procedure CopyFromResource()
    var
        Res: Record Resource;
    begin
        "WHT Product Posting Group" := Res."WHT Product Posting Group";  //PRU_RPG WHT_0.1
    end;

    local procedure CopyFromItemCharge()
    begin
        "WHT Product Posting Group" := ItemCharge."WHT Product Posting Group";  //PRU_RPG WHT_0.1
    end;


    local procedure InitHeaderDefaults(SalesHeader: Record 36)
    begin

        "WHT Business Posting Group" := SalesHeader."WHT Business Posting Group";   //PRU_RPG WHT_0.1

    end;

}