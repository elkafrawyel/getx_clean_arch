///represents what the API replies when performing operations on server.
///fill the type if you intend to return the reply with data
class OperationReply<ReturnType> {
  OperationStatus status;
  String message;
  ReturnType? returnData;

  OperationReply(this.status, {this.message = "message not set", this.returnData});

  bool isSuccess() {
    return status == OperationStatus.success;
  }

  bool isFailed() {
    return status == OperationStatus.failed;
  }

  bool isConnectionDown() {
    return status == OperationStatus.connectionDown;
  }

  ///casts the object to another type ONLY IF it holds no data
  as<NewType>() {
    assert(returnData == null);
    return OperationReply<NewType>(status, message: message);
  }

  factory OperationReply.failed({String message = "Error happened", returnData}) {
    return OperationReply(OperationStatus.failed, message: message, returnData: returnData);
  }

  factory OperationReply.success({String message = "message not set", returnData}) {
    return OperationReply(OperationStatus.success, message: message, returnData: returnData);
  }

  factory OperationReply.connectionDown({String message = "message not set", returnData}) {
    return OperationReply(OperationStatus.connectionDown, message: message, returnData: returnData);
  }

  factory OperationReply.fromReply(OperationReply reply, {OperationStatus? status, String? message, returnData}) {
    return OperationReply(
      status ?? reply.status,
      message: message ?? reply.message,
      returnData: returnData ?? reply.returnData,
    );
  }
}

enum OperationStatus { success, failed, notSet,connectionDown }
