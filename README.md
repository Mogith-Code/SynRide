# SyncRide: AI-Powered Smart Public Transport Intelligence & Occupancy Prediction Platform

---

## 📌 Project Overview

**SyncRide** is an AI-driven public transport intelligence and occupancy prediction mobile application built using **Flutter**.

Instead of relying on expensive hardware or optical sensors, **SyncRide leverages the existing conductor digital ticketing workflow**. Every ticket issued updates the cloud platform in real time, giving waiting passengers live crowd-density visibility, AI-predicted Estimated Time of Arrival (ETA), seat availability predictions, and smart multimodal route recommendations.

---

## 👥 Task Allocation & Responsibilities

The development of the SyncRide system is divided among the 4 team members:

| Member Name | Role | Primary Responsibility |
|---|---|---|
| **Mogith** | System Architect & State Management Lead | Flutter core architecture, BLoC state management, API services & cloud data integration |
| **Renujaan** | Passenger Mobile App & UI/UX Lead | Passenger hub screens, Google Maps live bus tracking, occupancy badges & FCM alert integration |
| **Rubashalini** | Conductor Mobile Module Lead | Digital ticketing UI, real-time ticket issuance sync, SQLite offline queue & cloud sync engine |
| **Asvinitha** | AI/ML & Analytics Dashboard Lead | AI ETA prediction integration, smart boarding algorithms, and Authority Analytics Dashboard views |

---

## 🏗️ Flutter Project Structure

```text
SynRIDE/
├── pubspec.yaml                  # Flutter dependencies configuration
├── lib/
│   ├── main.dart                 # Application entry point
│   ├── app.dart                  # Material app configuration & routing
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart   # Design system color tokens
│   │   │   ├── app_constants.dart# Global app constants
│   │   │   └── api_endpoints.dart# Backend API & Firebase routes
│   │   ├── network/
│   │   │   ├── api_client.dart   # HTTP REST client service
│   │   │   └── websocket_client.dart # WebSocket real-time connection manager
│   │   └── theme/
│   │       └── app_theme.dart    # Dark theme visual styling
│   ├── features/
│   │   ├── passenger/            # Passenger Experience Module (Renujaan)
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   ├── bus_model.dart
│   │   │   │   │   └── route_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── bus_repository.dart
│   │   │   ├── logic/
│   │   │   │   └── passenger_cubit/
│   │   │   │       ├── passenger_cubit.dart
│   │   │   │       └── passenger_state.dart
│   │   │   └── presentation/
│   │   │       ├── screens/
│   │   │       │   ├── passenger_home_screen.dart
│   │   │       │   ├── live_map_screen.dart
│   │   │       │   └── route_recommendation_screen.dart
│   │   │       └── widgets/
│   │   │           ├── occupancy_indicator_widget.dart
│   │   │           └── eta_card_widget.dart
│   │   ├── conductor/            # Conductor Ticketing Module (Rubashalini)
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   └── ticket_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── ticket_repository.dart
│   │   │   ├── logic/
│   │   │   │   └── conductor_cubit/
│   │   │   │       ├── conductor_cubit.dart
│   │   │   │       └── conductor_state.dart
│   │   │   └── presentation/
│   │   │       ├── screens/
│   │   │       │   ├── conductor_home_screen.dart
│   │   │       │   └── ticket_issuance_screen.dart
│   │   │       └── widgets/
│   │   │           └── ticket_counter_widget.dart
│   │   ├── analytics_dashboard/  # Transport Authority Module (Asvinitha)
│   │   │   ├── data/
│   │   │   │   └── models/
│   │   │   │       └── analytics_model.dart
│   │   │   └── presentation/
│   │   │       ├── screens/
│   │   │       │   └── authority_dashboard_screen.dart
│   │   │       └── widgets/
│   │   │           ├── occupancy_heatmap_chart.dart
│   │   │           └── demand_forecast_chart.dart
│   │   └── ai_prediction/        # AI & ETA Service Module (Mogith & Asvinitha)
│   │       └── data/
│   │           └── services/
│   │               └── eta_prediction_service.dart
│   └── shared_widgets/
│       ├── custom_button.dart
│       └── loading_indicator.dart
└── README.md
```

---

## 🗺️ Step-by-Step Approach to Develop the Application (using Flutter)

The development roadmap is structured into 6 sequential phases, with explicit task assignments for **Mogith**, **Renujaan**, **Rubashalini**, and **Asvinitha**:

```
Phase 1: Project Setup ──> Phase 2: Ticket Sync ──> Phase 3: Passenger App ──> Phase 4: AI & ETA ──> Phase 5: Authority Dash ──> Phase 6: Integration & Polish
```

### **Phase 1: Core Flutter Setup & State Architecture**
* Initialize Flutter application project structure and configure `pubspec.yaml` dependencies (`flutter_bloc`, `google_maps_flutter`, `firebase_core`, `firebase_database`, `fl_chart`, `sqflite`).
* Establish theme tokens (`AppColors`, `AppTheme`) and network connection interfaces (`ApiClient`, `WebSocketClient`).
* **Task Assignments:**
  * **Mogith**: Set up BLoC architecture framework, router setup, and core Firebase / REST communication interfaces.
  * **Renujaan**: Create UI theme guidelines, shared widgets, and scaffold initial passenger application routes.
  * **Rubashalini**: Configure SQLite local storage schema for conductor ticketing caching.
  * **Asvinitha**: Define analytics models and API response contracts for AI predictions.

---

### **Phase 2: Conductor Digital Ticket Sync Module**
* Build the ticket issuance workflow interface for bus conductors.
* Implement instantaneous increment/decrement triggers for bus passenger count.
* Wire offline-first local queue (SQLite) with automatic cloud sync upon reconnection.
* **Task Assignments:**
  * **Rubashalini (Lead)**: Build `ConductorHomeScreen`, `TicketIssuanceScreen`, and `TicketRepository`. Implement SQLite local caching and cloud sync listeners.
  * **Mogith**: Construct BLoC state management (`ConductorCubit`) and configure sub-second Firebase Realtime Database triggers.

---

### **Phase 3: Passenger App & Live Real-Time Tracking**
* Develop the passenger UI dashboard, search bar, and approaches list.
* Integrate Google Maps API for live bus marker updates and route polylines.
* Display visual crowd-density indicators (Low, Moderate, Standing Only, Overcrowded).
* **Task Assignments:**
  * **Renujaan (Lead)**: Implement `PassengerHomeScreen`, `LiveMapScreen`, and `OccupancyIndicatorWidget`. Integrate Google Maps Flutter SDK and live marker animations.
  * **Mogith**: Connect live bus state streams from Firebase to `PassengerCubit` for smooth real-time map updates.

---

### **Phase 4: AI Engine Integration & Smart Seating Predictions**
* Connect Flutter client with the Python machine learning backend services.
* Render AI-predicted Estimated Time of Arrival (ETA) badges based on live traffic, weather, and historical trip logs.
* Implement smart seating availability predictions at downstream stops.
* **Task Assignments:**
  * **Asvinitha (Lead)**: Build `EtaPredictionService`, seat availability prediction parser, and client models.
  * **Renujaan**: Render `EtaCardWidget` and seating availability indicators inside the passenger route cards.

---

### **Phase 5: Multimodal Route Recommendations & Authority Dashboard**
* Implement graph-based alternative route recommendations (suggesting faster buses or nearby trains when a line is delayed).
* Construct the Flutter-based Transportation Authority Dashboard featuring interactive charts (`fl_chart`) and congestion metrics.
* **Task Assignments:**
  * **Asvinitha (Lead)**: Develop `AuthorityDashboardScreen`, `OccupancyHeatmapChart`, and demand forecasting charts.
  * **Mogith**: Implement the `RouteRecommendationScreen` logic for multimodal alternative routing when buses are overcrowded.

---

### **Phase 6: Cross-Platform Testing, Polish & Deployment**
* Perform end-to-end field testing of ticket issuance sync under variable network bandwidth conditions.
* Refine micro-animations, glassmorphic UI cards, dark mode consistency, and screen responsiveness.
* Compile and build release packages (`apk`, `bundle`, `web`).
* **Task Assignments:**
  * **Mogith**: Conduct load and stress testing on WebSocket/Firebase real-time sync.
  * **Renujaan**: Audit UI design aesthetics, micro-interactions, and map performance.
  * **Rubashalini**: Verify offline ticket sync handling and low-latency button triggers.
  * **Asvinitha**: Verify chart render performance and prediction response latency.

---

## 🎯 Key Features Implemented

| Feature | Description | Member Lead |
|---|---|---|
| ⚡ **Real-Time Occupancy Monitoring** | Live bus passenger count syncs via conductor ticket issuance. | **Rubashalini & Mogith** |
| 🤖 **AI-Powered ETA Prediction** | ML models predict bus arrival times accurately. | **Asvinitha & Renujaan** |
| 🔀 **Smart Multimodal Recommendations** | AI suggests faster alternative bus or train routes when delays occur. | **Mogith** |
| 📊 **Authority Analytics Dashboard** | Real-time fleet metrics, congestion heatmaps, and demand charts. | **Asvinitha** |
| 🪑 **Smart Boarding Prediction** | Seat availability predictions before the bus reaches a stop. | **Asvinitha & Renujaan** |

---

## 💻 Quick Start Guide for Developers

### Prerequisites
* **Flutter SDK**: `3.16+`
* **Dart SDK**: `3.0+`

### Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/SyncRide/SyncRide.git
   cd SyncRide
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```

---
*SyncRide — AI-Powered Smart Public Transport Intelligence Platform built with Flutter.*
