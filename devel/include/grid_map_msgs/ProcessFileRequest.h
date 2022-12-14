// Generated by gencpp from file grid_map_msgs/ProcessFileRequest.msg
// DO NOT EDIT!


#ifndef GRID_MAP_MSGS_MESSAGE_PROCESSFILEREQUEST_H
#define GRID_MAP_MSGS_MESSAGE_PROCESSFILEREQUEST_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace grid_map_msgs
{
template <class ContainerAllocator>
struct ProcessFileRequest_
{
  typedef ProcessFileRequest_<ContainerAllocator> Type;

  ProcessFileRequest_()
    : file_path()
    , topic_name()  {
    }
  ProcessFileRequest_(const ContainerAllocator& _alloc)
    : file_path(_alloc)
    , topic_name(_alloc)  {
  (void)_alloc;
    }



   typedef std::basic_string<char, std::char_traits<char>, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<char>> _file_path_type;
  _file_path_type file_path;

   typedef std::basic_string<char, std::char_traits<char>, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<char>> _topic_name_type;
  _topic_name_type topic_name;





  typedef boost::shared_ptr< ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator> const> ConstPtr;

}; // struct ProcessFileRequest_

typedef ::grid_map_msgs::ProcessFileRequest_<std::allocator<void> > ProcessFileRequest;

typedef boost::shared_ptr< ::grid_map_msgs::ProcessFileRequest > ProcessFileRequestPtr;
typedef boost::shared_ptr< ::grid_map_msgs::ProcessFileRequest const> ProcessFileRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator1> & lhs, const ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator2> & rhs)
{
  return lhs.file_path == rhs.file_path &&
    lhs.topic_name == rhs.topic_name;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator1> & lhs, const ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace grid_map_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "d33bd97bc9ab242541cf320304eff29e";
  }

  static const char* value(const ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xd33bd97bc9ab2425ULL;
  static const uint64_t static_value2 = 0x41cf320304eff29eULL;
};

template<class ContainerAllocator>
struct DataType< ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "grid_map_msgs/ProcessFileRequest";
  }

  static const char* value(const ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# Absolute file path.\n"
"string file_path\n"
"\n"
"# For ROS bags: topic name that should be processed (optional).\n"
"string topic_name\n"
"\n"
;
  }

  static const char* value(const ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.file_path);
      stream.next(m.topic_name);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct ProcessFileRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::grid_map_msgs::ProcessFileRequest_<ContainerAllocator>& v)
  {
    s << indent << "file_path: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<char>>>::stream(s, indent + "  ", v.file_path);
    s << indent << "topic_name: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<char>>>::stream(s, indent + "  ", v.topic_name);
  }
};

} // namespace message_operations
} // namespace ros

#endif // GRID_MAP_MSGS_MESSAGE_PROCESSFILEREQUEST_H
