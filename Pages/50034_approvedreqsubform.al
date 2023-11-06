page 50034 approvedRequisitionSubForm
{
    PageType = ListPart;
    //UsageCategory = Administration;
    PopulateAllFields = true;
    //ApplicationArea = all;
    SourceTable = "Requisition_Line";
    Caption = 'Requisition SubForm';
    AutoSplitKey = true;
    Editable = true;
    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    /*  trigger OnLookup(var Text: Text): Boolean
                      var
                          ItemList: Page "Item List";
                          Item: Record 27;
                          fixedrec: Page "Fixed Asset List";
                          FixedRec1: Record "Fixed Asset";
                          GLRec: Record "G/L Account";
                          GlPage: Page "G/L Account List";
                          Req: Record "Requisition Header";
                      begin
                          Req.Get(rec."Requisition Slip No.");
                          Req.TestField("Store Location");
                          Req.TestField("Location Code");
                          if Rec.Type = Rec.Type::Item then begin
                              Item.Reset();
                              ItemList.SETTABLEVIEW(Item);
                              ItemList.LOOKUPMODE(TRUE);
                              if (ItemList.RunModal() = Action::LookupOK) then begin
                                  ItemList.GetRecord(Item);
                                  Rec.Validate("No.", Item."No.");
                                  rec.Description := Item.Description;
                                  rec."Unit Of Measure Code" := Item."Base Unit of Measure";
                              end;
                          END else
                              if (Rec.Type = Rec.Type::"Fixed Asset") then begin
                                  FixedRec1.Reset();
                                  fixedrec.SETTABLEVIEW(FixedRec1);
                                  fixedrec.LOOKUPMODE(TRUE);
                                  if (fixedrec.RunModal() = Action::LookupOK) then begin
                                      fixedrec.GetRecord(FixedRec1);
                                      Rec.Validate("No.", FixedRec1."No.");
                                      rec.Description := FixedRec1.Description;

                                  end;
                              end else
                                  if (Rec.Type = Rec.Type::"G/L Account") then begin
                                      GLRec.Reset();
                                      GlPage.SETTABLEVIEW(GLRec);
                                      GlPage.LOOKUPMODE(TRUE);
                                      if (GlPage.RunModal() = Action::LookupOK) then begin
                                          GlPage.GetRecord(GLRec);
                                          Rec.Validate("No.", GLRec."No.");
                                          rec.Description := GLRec.Name;

                                      end;
                                  end;
                      END;*/
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Request Quantity"; rec."Request Quantity")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Issued Quantity"; rec."Issued Quantity")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Post Issue Qty"; Rec."Post Issue Qty")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Unit Cost"; rec."Unit Cost")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Comment; rec.Comment)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Store Location"; rec."Store Location")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Stock In Hand"; rec."Stock In Hand")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

            }
        }
    }
}