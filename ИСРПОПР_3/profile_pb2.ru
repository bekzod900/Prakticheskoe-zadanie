# Generated-compatible Protobuf module. Regenerate with:
# python -m grpc_tools.protoc -I. --python_out=. profile.proto
# This checked-in version builds the same schema dynamically.
from google.protobuf import descriptor_pb2, descriptor_pool
from google.protobuf.internal import builder

_fd = descriptor_pb2.FileDescriptorProto()
_fd.name = "profile.proto"
_fd.syntax = "proto3"

_addr = _fd.message_type.add()
_addr.name = "Address"
for _name, _num in (("city", 1), ("zip", 2)):
    _f = _addr.field.add()
    _f.name, _f.number = _name, _num
    _f.label = descriptor_pb2.FieldDescriptorProto.LABEL_OPTIONAL
    _f.type = descriptor_pb2.FieldDescriptorProto.TYPE_STRING

_prof = _fd.message_type.add()
_prof.name = "Profile"
_fields = [
    ("id", 1, descriptor_pb2.FieldDescriptorProto.TYPE_INT32, None, False),
    ("name", 2, descriptor_pb2.FieldDescriptorProto.TYPE_STRING, None, False),
    ("age", 3, descriptor_pb2.FieldDescriptorProto.TYPE_INT32, None, False),
    ("is_student", 4, descriptor_pb2.FieldDescriptorProto.TYPE_BOOL, None, False),
    ("courses", 5, descriptor_pb2.FieldDescriptorProto.TYPE_STRING, None, True),
    ("address", 6, descriptor_pb2.FieldDescriptorProto.TYPE_MESSAGE, ".Address", False),
    ("email", 7, descriptor_pb2.FieldDescriptorProto.TYPE_STRING, None, False),
]
for _name, _num, _type, _type_name, _repeated in _fields:
    _f = _prof.field.add()
    _f.name, _f.number, _f.type = _name, _num, _type
    _f.label = (descriptor_pb2.FieldDescriptorProto.LABEL_REPEATED if _repeated
                else descriptor_pb2.FieldDescriptorProto.LABEL_OPTIONAL)
    if _type_name:
        _f.type_name = _type_name

DESCRIPTOR = descriptor_pool.Default().AddSerializedFile(_fd.SerializeToString())
builder.BuildMessageAndEnumDescriptors(DESCRIPTOR, globals())
builder.BuildTopDescriptorsAndMessages(DESCRIPTOR, __name__, globals())
