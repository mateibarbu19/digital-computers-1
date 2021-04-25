task check_test;
	input [31:0] value;
	input [31:0] expected_value;
	input [31:0] test_no;
	input        is_counter;
	begin
		if (value == expected_value) begin
			$display("TEST %0d: PASSED", test_no);
		end else begin
			if (!is_counter)
				$display("TEST %0d: res exp. value is %0d, not %0d - FAILED", test_no, expected_value, value);
			else
				$display("TEST %0d: reset button pressed of %0d times, not %0d - FAILED", test_no, value, expected_value);
		end
	end
endtask
