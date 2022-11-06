import SwiftUI

struct InspectionCard: View {
    @StateObject var viewmodel: InspectionCardViewModel
    @Orientation var orientation

    init(inspection: Inspection) {
        _viewmodel = StateObject(wrappedValue: .init(inspection: inspection))
    }

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            if orientation.isPortrait {
                // Left
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(viewmodel.getTitle())
                            .font(viewmodel.getTitleFont())
                            .foregroundColor(.Label.primary)
                        if viewmodel.inspection.inspectionStatus == .planned {
                            Text("| \(viewmodel.getSubtitle())")
                                .font(Font.HabiCen.footnoteBold)
                                .foregroundColor(.Label.secondary)
                        }
                    }
                    Text(viewmodel.getInspectionText())
                        .font(Font.HabiCen.footnoteBold)
                        .foregroundColor(viewmodel.getInspectionColor())
                }
                .frame(minWidth: 125, alignment: .leading)

                // Right
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 4) {
                        Text(String.Awesome.Location)
                            .font(Font.Awesome)
                            .frame(maxWidth: 20, maxHeight: 22)
                        Text(viewmodel.inspection.lease?.getFullAddress() ?? "card.address.missing")
                            .font(Font.HabiCen.body)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    .frame(maxWidth: .infinity, minHeight: 22, alignment: .leading)

                    HStack(spacing: 4) {
                        Text(String.Awesome.House)
                            .font(Font.Awesome)
                            .frame(maxWidth: 20, maxHeight: 22)
                        Text(viewmodel.inspection.tenant?.getLeaseNumber() ?? "card.tenant.missing")
                            .font(Font.HabiCen.body)
                    }
                    .frame(maxWidth: .infinity, minHeight: 22, alignment: .leading)
                    if let responsible = viewmodel.inspection.responsible {
                        HStack(spacing: 4) {
                            Text(String.Awesome.User)
                                .font(Font.Awesome)
                                .frame(maxWidth: 20, maxHeight: 22)
                            Text(responsible.name)
                                .lineLimit(1)
                                .font(Font.HabiCen.body).truncationMode(.tail)
                        }
                        .frame(maxWidth: .infinity, minHeight: 22, alignment: .leading)
                    }
                }
                .foregroundColor(.Label.secondary)
            } else {
                VStack(spacing: 4) {
                    // Top
                    HStack {
                        HStack {
                            Text(viewmodel.getTitle())
                                .font(viewmodel.getTitleFont())
                                .foregroundColor(.Label.primary)
                            if viewmodel.inspection.inspectionStatus == .planned {
                                Text("| \(viewmodel.getSubtitle())")
                                    .font(Font.HabiCen.footnoteBold)
                                    .foregroundColor(.Label.secondary)
                            }
                        }
                        Spacer()
                        Text(viewmodel.getInspectionText())
                            .font(Font.HabiCen.footnoteBold)
                            .foregroundColor(viewmodel.getInspectionColor())
                    }

                    // Bottom
                    HStack(spacing: 16) {
                        HStack(spacing: 4) {
                            Text(String.Awesome.Location)
                                .font(Font.Awesome)
                                .frame(maxWidth: 20, maxHeight: 22)
                            Text(viewmodel.inspection.lease?.getFullAddress() ?? "card.address.missing")
                                .font(Font.HabiCen.body)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        if let responsible = viewmodel.inspection.responsible {
                            HStack(spacing: 4) {
                                Text(String.Awesome.User)
                                    .font(Font.Awesome)
                                    .frame(maxWidth: 20, maxHeight: 22)
                                Text(responsible.name)
                                    .font(Font.HabiCen.body)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }

                        HStack(spacing: 4) {
                            Text(String.Awesome.House)
                                .font(Font.Awesome)
                                .frame(maxWidth: 20, maxHeight: 22)
                            Text(viewmodel.inspection.tenant?.getLeaseNumber() ?? "card.tenant.missing")
                                .font(Font.HabiCen.body)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.Label.secondary)
                }
            }
        }
        .padding(.all, 16)
        .background(Color.SystemGroupedBackgroundColor.tertiary)
        .cornerRadius(8)
        .shadowStyle(.shadow100)
        .padding(.horizontal, 20)
    }
}
