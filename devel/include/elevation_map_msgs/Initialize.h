// Generated by gencpp from file elevation_map_msgs/Initialize.msg
// DO NOT EDIT!


#ifndef ELEVATION_MAP_MSGS_MESSAGE_INITIALIZE_H
#define ELEVATION_MAP_MSGS_MESSAGE_INITIALIZE_H

#include <ros/service_traits.h>


#include <elevation_map_msgs/InitializeRequest.h>
#include <elevation_map_msgs/InitializeResponse.h>


namespace elevation_map_msgs
{

struct Initialize
{

typedef InitializeRequest Request;
typedef InitializeResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct Initialize
} // namespace elevation_map_msgs


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::elevation_map_msgs::Initialize > {
  static const char* value()
  {
    return "2132848049aeee984c2fb7de662fe983";
  }

  static const char* value(const ::elevation_map_msgs::Initialize&) { return value(); }
};

template<>
struct DataType< ::elevation_map_msgs::Initialize > {
  static const char* value()
  {
    return "elevation_map_msgs/Initialize";
  }

  static const char* value(const ::elevation_map_msgs::Initialize&) { return value(); }
};


// service_traits::MD5Sum< ::elevation_map_msgs::InitializeRequest> should match
// service_traits::MD5Sum< ::elevation_map_msgs::Initialize >
template<>
struct MD5Sum< ::elevation_map_msgs::InitializeRequest>
{
  static const char* value()
  {
    return MD5Sum< ::elevation_map_msgs::Initialize >::value();
  }
  static const char* value(const ::elevation_map_msgs::InitializeRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::elevation_map_msgs::InitializeRequest> should match
// service_traits::DataType< ::elevation_map_msgs::Initialize >
template<>
struct DataType< ::elevation_map_msgs::InitializeRequest>
{
  static const char* value()
  {
    return DataType< ::elevation_map_msgs::Initialize >::value();
  }
  static const char* value(const ::elevation_map_msgs::InitializeRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::elevation_map_msgs::InitializeResponse> should match
// service_traits::MD5Sum< ::elevation_map_msgs::Initialize >
template<>
struct MD5Sum< ::elevation_map_msgs::InitializeResponse>
{
  static const char* value()
  {
    return MD5Sum< ::elevation_map_msgs::Initialize >::value();
  }
  static const char* value(const ::elevation_map_msgs::InitializeResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::elevation_map_msgs::InitializeResponse> should match
// service_traits::DataType< ::elevation_map_msgs::Initialize >
template<>
struct DataType< ::elevation_map_msgs::InitializeResponse>
{
  static const char* value()
  {
    return DataType< ::elevation_map_msgs::Initialize >::value();
  }
  static const char* value(const ::elevation_map_msgs::InitializeResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // ELEVATION_MAP_MSGS_MESSAGE_INITIALIZE_H