class User {
  int age;
  String interests;
  bool isStudent;

  User(this.age, this.interests, this.isStudent);
}

class RecommendationEngine {
  String getRecommendations(User user) {
    if (user.isStudent) {
      if (user.age < 20) {
        return _recommendationsForYoungStudents(user);
      } else {
        return _recommendationsForMatureStudents(user);
      }
    } else {
      if (user.interests.contains('sports')) {
        return _sportsRecommendations(user);
      } else if (user.interests.contains('technology')) {
        return _technologyRecommendations(user);
      } else {
        return _generalRecommendations(user);
      }
    }
  }

  String _recommendationsForYoungStudents(User user) {
    if (user.interests.contains('music')) {
      return 'Join a music club or learn a new instrument.';
    } else {
      return 'Participate in student exchange programs.';
    }
  }

  String _recommendationsForMatureStudents(User user) {
    if (user.age > 25) {
      return 'Consider part-time job opportunities or internships.';
    } else {
      return 'Engage in campus activities and networking events.';
    }
  }

  String _sportsRecommendations(User user) {
    return 'Participate in local sports clubs or events.';
  }

  String _technologyRecommendations(User user) {
    return 'Attend tech meetups and participate in hackathons.';
  }

  String _generalRecommendations(User user) {
    return 'Explore new hobbies and attend community events.';
  }
}