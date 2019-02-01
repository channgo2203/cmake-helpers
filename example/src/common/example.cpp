// Copyright (C) 2019 Bolt Robotics <info@boltrobotics.com>
// License: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

// SYSTEM INCLUDES
#if defined(x86)
#include <iostream>
#elif defined(avr)
#include <Arduino.h>
#endif

// PROJECT INCLUDES
#include "example.hpp"  // class implemented

namespace btr
{

/////////////////////////////////////////////// PUBLIC /////////////////////////////////////////////

//============================================= LIFECYCLE ==========================================

Example::Example()
{
}

//============================================= OPERATIONS =========================================

bool Example::hello()
{
#if defined(x86)
  std::cout << "Hello" << std::endl;
#elif defined(avr)
  Serial.println("Hello");
#elif defined (stm32)
#endif
  return true;
}

/////////////////////////////////////////////// PROTECTED //////////////////////////////////////////

//============================================= OPERATIONS =========================================

/////////////////////////////////////////////// PRIVATE ////////////////////////////////////////////

//============================================= OPERATIONS =========================================

} // namespace btr