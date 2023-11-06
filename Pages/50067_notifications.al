page 50067 Notifications
{
    PageType = List;
    Caption = 'Notifications';
    UsageCategory = Administration;
    ApplicationArea = all;
    Editable = false;
    SourceTable = Notifications;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("User ID"; Rec."User ID")
                {
                    // ApplicationArea = All;
                }
                field(recordID; Rec.recordID)
                {
                    // ApplicationArea = all;
                }
                field(Notificationdatetime; Rec.Notificationdatetime)
                {
                    Caption = 'Date-Time';
                    ApplicationArea = all;
                }
                field("Notification details"; Rec."Notification details")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        recordre: RecordRef;
                        tableno: Integer;
                        catering: Record "Catering Header";
                        genbatch: Record "Gen. Journal Batch";
                        genjnlline: Record "Gen. Journal Line";
                    begin
                        recordre := Rec.recordID.GetRecord();
                        case recordre.Number of
                            database::"Catering Header":
                                begin
                                    recordre.SetTable(catering);
                                    page.Run(page::"Catering Card", catering);
                                end;
                            Database::"Gen. Journal Batch":
                                begin
                                    recordre.SetTable(genbatch);
                                    genjnlline.SetRange("Journal Template Name", genbatch."Journal Template Name");
                                    genjnlline.SetRange("Journal Batch Name", genbatch.Name);
                                    if genjnlline.FindFirst() then
                                        page.run(page::"Payment Journal", genjnlline);
                                end;
                        end;
                        rec.Delete();
                    end;
                }
            }
        }
    }
}