import 'package:shop_app/src/modules/profile_edit/controllers/profile_edit_controller.dart';

import '../../../public/components.dart';
import '../../../core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../../routes/app_pages.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/sizer_custom/sizer.dart';

class AddressView extends StatefulWidget {
  const AddressView({super.key});

  @override
  State<AddressView> createState() => _AddressViewState();
}

const kGoogleApiKey = "AIzaSyAj2MKle2E-Z-ZeWlqr3m_d0h5usgTEzg4";
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _AddressViewState extends State<AddressView> {
  late GoogleMapController _mapController;

  Set<Marker> markersList = {};

  // final Mode _mode = Mode.overlay;

  String _address = '';
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileEditController>(
      builder: (profileEditController) {
        _address =
            '${profileEditController.placemark.value.administrativeArea ?? ''}${profileEditController.placemark.value.locality ?? ''}${profileEditController.placemark.value.street ?? ''}${profileEditController.placemark.value.postalCode ?? ''}';
        return Scaffold(
          key: homeScaffoldKey,
          body: Stack(
            children: [
              GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                  target: profileEditController.initPosition,
                  zoom: 17.0,
                ),
                markers: markersList,
                onTap: (latLng) {
                  markersList.clear();
                  markersList.add(
                    Marker(
                      markerId: const MarkerId('0'),
                      position: LatLng(latLng.latitude, latLng.longitude),
                    ),
                  );
                  setState(() {});
                },
                myLocationEnabled: true,
                onMapCreated: (GoogleMapController controller) =>
                    _mapController = controller,
                zoomControlsEnabled: true,
                compassEnabled: false,
                indoorViewEnabled: true,
                mapToolbarEnabled: false,
                onCameraMove: ((position) {
                  profileEditController.initPosition = LatLng(
                    position.target.latitude,
                    position.target.longitude,
                  );
                }),
                onCameraIdle: () {
                  profileEditController.updatePosition(profileEditController.initPosition);
                },
              ),
              // Center(
              //   child: addressCtrl.loading
              //       ? const CustomLoader()
              //       : Image.asset(
              //           'assets/images/maps_marker.jpg',
              //           width: 100,
              //           height: 100,
              //         ),
              // ),
              Positioned(
                top: 40.sp,
                left: 20.sp,
                right: 20.sp,
                child: InkWell(
                  onTap: () {},
                  //_handlePressButton(),
                  // Get.dialog(AddressSearch(mapController: _mapController)),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.sp),
                    height: 40.sp,
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius:
                          BorderRadius.circular(10.sp),
                    ),
                    child: GetBuilder<ProfileEditController>(
                        builder: (profileEditController) {
                      return Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 20.sp,
                            color: colorBranch,
                          ),
                          SizedBox(
                            width: 20.sp
                          ),
                          Expanded(
                            child: Text(
                              _address,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.sp),
                          Icon(
                            Icons.search,
                            size: 20.sp,
                            color: colorBranch,
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
              Positioned(
                bottom: 100.sp,
                right: 20.sp,
                left: 20.sp,
                child: CustomButton(
                  buttomText: 'Pick address',
                  onPressed: profileEditController.isLoading
                      ? null
                      : () {
                          if (_address.isNotEmpty) {
                            AppNavigator.pop();
                          }
                        },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void onError(PlacesAutocompleteResponse response) {
    Components.showSnackBar(response.errorMessage!);
  }

  // Future<void> _handlePressButton() async {
  //   Prediction? p = await PlacesAutocomplete.show(
  //       context: context,
  //       apiKey: kGoogleApiKey,
  //       onError: onError,
  //       mode: _mode,
  //       language: 'en',
  //       strictbounds: false,
  //       types: [''],
  //       decoration: InputDecoration(
  //         hintText: 'Search',
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(Dimensions.radius20),
  //           borderSide: const BorderSide(
  //             color: mcl,
  //           ),
  //         ),
  //       ),
  //       components: [
  //         Component(
  //           Component.country,
  //           'pk',
  //         ),
  //       ]);

  //   displayPrediction(p!, homeScaffoldKey.currentState);
  // }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markersList.clear();
    markersList.add(
      Marker(
        markerId: const MarkerId('0'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: detail.result.name,
        ),
      ),
    );
    setState(() {});

    _mapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 17));
  }
}