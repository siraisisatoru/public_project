--      << bool 1 >>  if true   -> {A,B,C,D} => {=,0,C,D}
--      << bool 3 >>  if true   -> {=,0,C,D} => {=,0,-,0}
--      << bool 2 >>  if true   -> {=,0,-,0} => {=,0,-,0}

--      << bool 1 >>  if true   -> {A,B,C,D} => {=,0,C,D}
--      << bool 3 >>  if true   -> {=,0,C,D} => {=,0,-,0}
--      << bool 2 >>  if false  -> {=,0,-,0} => {=,0,-,0}

--      << bool 1 >>  if true   -> {A,B,C,D} => {=,0,C,D}
--      << bool 3 >>  if false   -> {=,0,C,D} => {=,0,C,D}
--      << bool 2 >>  if true  -> {=,0,C,D} => {=,0,C,D}

--      << bool 1 >>  if true   -> {A,B,C,D} => {=,0,C,D}
--      << bool 3 >>  if false   -> {=,0,C,D} => {=,0,C,D}
--      << bool 2 >>  if false  -> {=,0,C,D} => {=,0,C,D}
------
--      << bool 1 >>  if false   -> {A,B,C,D} => {A,B,C,D}
--      << bool 3 >>  if true   -> {A,B,C,D} => {A,B,=,0}
--      << bool 2 >>  if true   -> {A,B,=,0} => {A,B,=,0}

--      << bool 1 >>  if false   -> {A,B,C,D} => {A,B,C,D}
--      << bool 3 >>  if true   -> {A,B,C,D} => {A,B,=,0}
--      << bool 2 >>  if false  -> {A,B,=,0} => {A,B,=,0}

--      << bool 1 >>  if false   -> {A,B,C,D} => {A,B,C,D}
--      << bool 3 >>  if false   -> {A,B,C,D} => {A,B,C,D}
--      << bool 2 >>  if true  -> {A,B,C,D} => {A,=,0,D}

--      << bool 1 >>  if false   -> {A,B,C,D} => {A,B,C,D}
--      << bool 3 >>  if false   -> {A,B,C,D} => {A,B,C,D}
--      << bool 2 >>  if false  -> {A,B,C,D} => {A,B,C,D}


