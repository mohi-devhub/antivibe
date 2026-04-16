import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/users")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/{id}")
    public Optional<User> getUser(@PathVariable Long id) {
        return userService.findById(id);
    }

    @PostMapping
    public User createUser(@RequestBody UserDTO dto) {
        return userService.create(dto);
    }

    private void validateUser(UserDTO dto) {
        if (dto.getName() == null) throw new IllegalArgumentException("Name required");
    }
}
