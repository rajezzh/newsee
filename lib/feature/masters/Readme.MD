## Designing Master Download / Update Feature

AsyncResposeHandler<L,R> -> L - Failure , R- InterestMaster , ProductMaster ,MainProduct , Subproduct

For Handling Error

Master Error Response
{
"errorCode": "002",
"errorDesc": "Technical error occured please try again later"
}

For Handling Success

class MasterResponse<T> {
// json serialization deserialization not required
final List<T> mastersList;

    MasterResponse(this.master);

}

class LovMaster{

<!--
 "Header": "IrrigationNew",
                "optvalue": "1",
                "optDesc": "River"
 -->

final String Header;
final String optvalue;
final String optDesc;

}

class InterestMaster{

}

class ProductMaster{

}
