// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'hotel.dart';

class HotelsRepository {
  static List<Hotel> loadHotels() {
    return <Hotel> [
      const Hotel(
          id: 0,
          isFeatured: true,
          star: 3,
          name: '라한호텔 포항',
          address: '경상북도 포항시 북구 삼호로265번길 1 KR',
          phone: '054-230-7000',
          content:
            '가장 가까운 버스 정류장에서 50m 거리의 대로변에 위치한 이 현대적인 호텔은 영일대 해수욕장에서 버스로 19분, 포항시립미술관에서 버스로 11분 거리입니다.'
            '화사한 스탠다드룸에 무료 Wi-Fi, 평면 TV, 에어컨, 차 및 커피 메이커가 구비되어 있습니다. 스위트룸에는 거실 또는 다이닝룸이 추가되며 일부 객실에는 간이 주방이 있습니다. 전통적인 온돌 방식의 객실과 스위트룸도 있습니다.'
            '조식 뷔페는 바다가 보이는 발코니와 식사 공간이 있는 레스토랑에서 제공됩니다. 기타 편의시설로는 비즈니스 센터와 이벤트 공간이 있습니다.'
            '체크인 시간: 오후 3:00'
            '체크아웃 시간: 오전 11:00'
      ),
      const Hotel(
          id: 1,
          isFeatured: true,
          star: 1,
          name: 'Hotel View 뷰호텔',
          address: '경상북도 포항시 해안로 91 KR',
          phone: '010-6651-3133',
          content:
            '영일대 해수욕장 건너편에 자리한 이 깔끔한 호텔은 영일만이 내려다보이는 공원에 자리한 포항시립미술관에서 버스로 12분 거리에 있습니다. 포항여객선터미널에서는 세 블록 떨어져 있습니다.'
            '편안한 분위기의 객실에 Wi-Fi, 평면 TV, 미니 냉장고, 차 및 커피 메이커가 구비되어 있습니다. 일부 객실은 바다가 보이거나 온돌과 바닥에 깔 수 있는 요를 갖추고 있습니다. 상위 등급 객실에는 안마 의자가 마련되어 있습니다.'
            '편의시설로는 비즈니스 센터, 코인 세탁실, 주차장이 있습니다. 조식이 제공됩니다.'
            '체크인 시간: 오후 4:00'
            '체크아웃 시간: 오전 12:00'
      ),
      const Hotel(
          id: 2,
          isFeatured: false,
          star: 2,
          name: '포항 필로스호텔',
          address: '경상북도 포항시 북구 죽파로 6 KR',
          phone: '054-250-2000',
          content:
            '상점이 즐비한 중심가에서 반 블록 떨어진 이 세련된 호텔은 영일대 해수욕장에서 버스로 22분, 포항시립미술관에서 버스로 30분 거리에 있습니다. 포항공항에서는 버스로 45분 거리에 있습니다.'
            '편안한 분위기의 객실에 Wi-Fi, 평면 TV, 미니 냉장고, 소파가 구비되어 있습니다. 온돌 바닥으로 된 일부 객실에는 이불이 마련되어 있습니다. 스위트룸에는 휴식 공간 또는 별도의 거실이 제공됩니다.'
            '이벤트 공간, 조식, 주차장도 이용 가능합니다.'
            '체크인 시간: 오후 2:00'
            '체크아웃 시간: 오전 11:00'
      ),
      const Hotel(
          id: 3,
          isFeatured: true,
          star: 3,
          name: '갤럭시호텔',
          address: '경상북도 포항시 북구 해안로 93',
          phone: '054-251-9988',
          content:
            '해변 건너편에 위치한 이 편안한 분위기의 호텔은 버스 정류장에서 도보 1분, 포항시립미술관에서 버스로 9분 거리에 있습니다.'
            '깔끔한 객실에 평면 TV, 무료 Wi-Fi, 미니 냉장고, 차 및 커피 메이커가 구비되어 있습니다. 일부 객실에는 이불이 제공됩니다. 스위트룸에는 별도의 거실이 있습니다.'
            '피자 전문점, 캐주얼한 루프톱 식당, 통유리창을 통해 바다가 보이는 현대적인 레스토랑 등 식당 3곳이 있습니다. 편의시설로는 노래방, 미용실, 현대 미술 갤러리도 있습니다.'
            '체크인 시간: 오후 4:00'
            '체크아웃 시간: 오전 11:00'
      ),
      const Hotel(
          id: 4,
          isFeatured: false,
          star: 1,
          name: '포항 아쿠아베이글램핑펜션',
          address: '경북 포항시 남구 운하로 207-21',
          phone: '054-1644-1346',
          content:
            '펜션은 미성년자의 경우 부모님 동반 외에 입실 불가하며 위반 시 환불이 불가하며 퇴실조치 됩니다.'
            '예약 인원에서 인원이 추가되는 경우 펜션에 미리 연락을 주시기 바랍니다.'
            '기준인원 초과 시 추가 인원에 대한 비용이 별도로 발생할 수 있습니다.'
            '최대 인원 초과 시 입실이 불가능할 수 있으며, 해당 사유로 환불 받을 수 없습니다.'
            '반려동물 동반 시 입실이 거부될 수 있으며, 해당 사유로 환불 받을 수 없습니다.'
            '다음 이용 고객을 위해 입실, 퇴실 시간을 준수해 주시기 바랍니다.'
            '객실 및 주변시설 이용 시 시설물의 훼손, 분실에 대한 책임은 투숙객에게 있으며, 손해배상의 책임을 질 수 있습니다.'
            '객실의 안전과 화재예방을 위해 객실 내에서 생선이나 고기 등을 굽는 직화 방식은 허용되지 않으며, 개인적으로 준비해 오는 취사도구(그릴, 숯, 전기/전열기구 등)은 반입이 금지되어 있습니다.'
            '객실 내에서의 흡연은 금지되어 있으며, 지정된 장소를 이용해 주시기 바랍니다.'
            '다른 이용객에게 피해를 줄 수 있는 무분별한 오락, 음주, 고성방가는 삼가주시기 바랍니다.'
            '실시간예약 시 중복예약이 발생할 수 있으며, 해당 사유의 경우 고객센터를 통해 전액 환불받을 수 있습니다. (야놀자펜션 고객센터 측에서 확인 즉시 안내드립니다.)'
            '펜션별 기간 미확정으로 인해 요금 및 요금표가 잘못 반영된 경우, 자동 예약 취소 처리되며 정상 금액으로 재예약할 수 있습니다.'
            '체크인 시간: 오후 3:00'
            '체크아웃 시간: 오전 11:00'
      ),
      const Hotel(
          id: 5,
          isFeatured: false,
          star: 2,
          name: '포항스테이호텔',
          address: '경북 포항시 남구 중앙로131번길 1',
          phone: '0507-1405-8300',
          content:
            '포항스테이호텔은 KTX 포항역에서 차로 약 25분 거리에 있으며, 포항시외버스터미널에서 10분, 포항고속버스터미널에서 3분 거리에 자리하고 있습니다.'
            '주변 관광명소로는 차로 약 50분 거리에 호미곶과 호미곶해맞이광장, 국립등대박물관이 있어 다양한 볼거리를 즐길 수 있습니다.'
            '또한, 차로 약 15분 거리에 영일대 해수욕장이, 약 35분 거리에 칠포해수욕장이 있습니다.남구의 유명한 지역에 있는 이 호텔에서는 지역의 관광 명소와 도보 거리에 있습니다.'
            '그 밖에도 내부 어디에서든 무료로 인터넷에 접속하실 수 있습니다.이 호텔에서는 리셉션을 24시간 운영하고 있고 카페, 회의실, 자전거 대여 서비스도 갖춰져 있습니다.'
            '컨시어지 서비스, 공항 셔틀, 세탁 시설 등도 마련되어 있어 편리하게 이용하실 수 있습니다.'
            '모든 객실에는 에어컨이 완비되어 있고 커피/차 메이커, 케이블/위성 채널 및 냉장고도 제공하고 있습니다. 각 객실에 객실 내 인터넷, 생수, 평면 TV 등이 완비되어 있습니다.호텔의 고객님들은 내부에 있는 레스토랑에서 식사를 드실 수 있습니다. 저녁에 여유롭게 술 한잔과 함께 휴식을 즐기실 수 있는 편안한 느낌의 라운지 바가 있습니다.'
            ''
            '체크인 시간: 오후 3:00'
            '체크아웃 시간: 오전 11:00'
      ),
    ];
  }
}
