/// Offline Postal Index Number (PIN) code prefix resolver.
///
/// Maps 2-digit and 3-digit Indian postal prefixes to state codes and regions,
/// enabling instant auto-fill during onboarding and profile setup.
///
/// Source: Department of Posts / India Post PIN directory open data.
library;

class PinCodeLookupResult {
  const PinCodeLookupResult({
    required this.stateCode,
    required this.regionName,
    this.suggestedDistricts = const [],
  });

  /// 2-letter state code matching [districtsByStateCode] (e.g. 'DL', 'MH', 'KA').
  final String stateCode;

  /// Postal circle / region name.
  final String regionName;

  /// High-probability districts in this PIN circle.
  final List<String> suggestedDistricts;
}

abstract final class PinCodeResolver {
  /// Resolves a 6-digit Indian PIN code to state code and region info.
  /// Returns null if the PIN format is invalid or unknown prefix.
  static PinCodeLookupResult? resolve(String pin) {
    final cleaned = pin.trim().replaceAll(RegExp(r'\s+'), '');
    if (cleaned.length != 6 || int.tryParse(cleaned) == null) {
      return null;
    }

    final prefix2 = cleaned.substring(0, 2);

    return switch (prefix2) {
      '11' => const PinCodeLookupResult(
        stateCode: 'DL',
        regionName: 'Delhi',
        suggestedDistricts: [
          'Central Delhi',
          'New Delhi',
          'South Delhi',
          'North Delhi',
        ],
      ),
      '12' || '13' => const PinCodeLookupResult(
        stateCode: 'HR',
        regionName: 'Haryana',
        suggestedDistricts: [
          'Gurugram',
          'Faridabad',
          'Ambala',
          'Karnal',
          'Panipat',
        ],
      ),
      '14' || '15' || '16' => const PinCodeLookupResult(
        stateCode: 'PB',
        regionName: 'Punjab & Chandigarh',
        suggestedDistricts: [
          'Ludhiana',
          'Amritsar',
          'Jalandhar',
          'Patiala',
          'SAS Nagar',
        ],
      ),
      '17' => const PinCodeLookupResult(
        stateCode: 'HP',
        regionName: 'Himachal Pradesh',
        suggestedDistricts: ['Shimla', 'Kangra', 'Mandi', 'Solan'],
      ),
      '18' || '19' => const PinCodeLookupResult(
        stateCode: 'JK',
        regionName: 'Jammu & Kashmir',
        suggestedDistricts: ['Jammu', 'Srinagar', 'Anantnag', 'Baramulla'],
      ),
      '20' ||
      '21' ||
      '22' ||
      '23' ||
      '24' ||
      '25' ||
      '26' ||
      '27' ||
      '28' => const PinCodeLookupResult(
        stateCode: 'UP',
        regionName: 'Uttar Pradesh',
        suggestedDistricts: [
          'Lucknow',
          'Kanpur Nagar',
          'Varanasi',
          'Noida (G.B. Nagar)',
          'Prayagraj',
          'Agra',
        ],
      ),
      '30' || '31' || '32' || '33' || '34' => const PinCodeLookupResult(
        stateCode: 'RJ',
        regionName: 'Rajasthan',
        suggestedDistricts: [
          'Jaipur',
          'Jodhpur',
          'Kota',
          'Udaipur',
          'Bikaner',
          'Ajmer',
        ],
      ),
      '36' || '37' || '38' || '39' => const PinCodeLookupResult(
        stateCode: 'GJ',
        regionName: 'Gujarat',
        suggestedDistricts: [
          'Ahmedabad',
          'Surat',
          'Vadodara',
          'Rajkot',
          'Gandhinagar',
        ],
      ),
      '40' || '41' || '42' || '43' || '44' => const PinCodeLookupResult(
        stateCode: 'MH',
        regionName: 'Maharashtra',
        suggestedDistricts: [
          'Mumbai',
          'Pune',
          'Nagpur',
          'Thane',
          'Nashik',
          'Chhatrapati Sambhajinagar',
        ],
      ),
      '45' || '46' || '47' || '48' => const PinCodeLookupResult(
        stateCode: 'MP',
        regionName: 'Madhya Pradesh',
        suggestedDistricts: [
          'Bhopal',
          'Indore',
          'Jabalpur',
          'Gwalior',
          'Ujjain',
        ],
      ),
      '49' => const PinCodeLookupResult(
        stateCode: 'CG',
        regionName: 'Chhattisgarh',
        suggestedDistricts: ['Raipur', 'Bilaspur', 'Durg', 'Bhilai'],
      ),
      '50' => const PinCodeLookupResult(
        stateCode: 'TG',
        regionName: 'Telangana',
        suggestedDistricts: [
          'Hyderabad',
          'Rangareddy',
          'Medchal-Malkajgiri',
          'Warangal',
        ],
      ),
      '51' || '52' || '53' => const PinCodeLookupResult(
        stateCode: 'AP',
        regionName: 'Andhra Pradesh',
        suggestedDistricts: [
          'Visakhapatnam',
          'Vijayawada (NTR)',
          'Guntur',
          'Tirupati',
        ],
      ),
      '56' || '57' || '58' || '59' => const PinCodeLookupResult(
        stateCode: 'KA',
        regionName: 'Karnataka',
        suggestedDistricts: [
          'Bengaluru Urban',
          'Mysuru',
          'Dakshina Kannada (Mangaluru)',
          'Dharwad',
        ],
      ),
      '60' || '61' || '62' || '63' || '64' => const PinCodeLookupResult(
        stateCode: 'TN',
        regionName: 'Tamil Nadu',
        suggestedDistricts: [
          'Chennai',
          'Coimbatore',
          'Madurai',
          'Tiruchirappalli',
          'Salem',
        ],
      ),
      '67' || '68' || '69' => const PinCodeLookupResult(
        stateCode: 'KL',
        regionName: 'Kerala',
        suggestedDistricts: [
          'Thiruvananthapuram',
          'Ernakulam',
          'Kozhikode',
          'Thrissur',
        ],
      ),
      '70' || '71' || '72' || '73' || '74' => const PinCodeLookupResult(
        stateCode: 'WB',
        regionName: 'West Bengal',
        suggestedDistricts: [
          'Kolkata',
          'North 24 Parganas',
          'Howrah',
          'Darjeeling',
        ],
      ),
      '75' || '76' || '77' => const PinCodeLookupResult(
        stateCode: 'OD',
        regionName: 'Odisha',
        suggestedDistricts: [
          'Khordha (Bhubaneswar)',
          'Cuttack',
          'Sundargarh (Rourkela)',
          'Ganjam',
        ],
      ),
      '78' => const PinCodeLookupResult(
        stateCode: 'AS',
        regionName: 'Assam',
        suggestedDistricts: [
          'Kamrup Metropolitan (Guwahati)',
          'Dibrugarh',
          'Silchar',
        ],
      ),
      '79' => const PinCodeLookupResult(
        stateCode: 'NE',
        regionName: 'North Eastern States',
        suggestedDistricts: [
          'East Khasi Hills (Shillong)',
          'Imphal West',
          'Aizawl',
          'Agartala',
          'Kohima',
        ],
      ),
      '80' || '81' || '82' || '83' || '84' || '85' => const PinCodeLookupResult(
        stateCode: 'BR',
        regionName: 'Bihar & Jharkhand',
        suggestedDistricts: [
          'Patna',
          'Ranchi',
          'Gaya',
          'Muzaffarpur',
          'East Singhbhum (Jamshedpur)',
        ],
      ),
      _ => null,
    };
  }
}
